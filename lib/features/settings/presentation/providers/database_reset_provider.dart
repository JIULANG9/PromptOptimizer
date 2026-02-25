import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../database/app_database.dart';
import '../../../../database/seed/database_seeder.dart';
import '../../../../database/seed/default_ai_apps.dart';

/// 数据库重置提供者
final databaseResetProvider =
    StateNotifierProvider<DatabaseResetNotifier, AsyncValue<void>>((ref) {
  return DatabaseResetNotifier();
});

/// 数据库重置 Notifier
class DatabaseResetNotifier extends StateNotifier<AsyncValue<void>> {
  DatabaseResetNotifier() : super(const AsyncValue.data(null));

  /// 重置所有数据库（Hive + SQLite）
  Future<void> resetAllDatabases() async {
    state = const AsyncValue.loading();
    try {
      // 1. 清空 Hive 数据库
      await _resetHiveDatabases();

      // 2. 清空 SQLite 数据库并重新初始化
      await _resetSQLiteDatabase();

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// 重置 Hive 数据库
  Future<void> _resetHiveDatabases() async {
    try {
      // 清空设置 Box
      final settingsBox = Hive.box(AppConstants.settingsBoxName);
      await settingsBox.clear();

      // 清空 AI 应用启动器状态 Box
      final aiAppLauncherBox = Hive.box(AppConstants.aiAppLauncherBoxName);
      await aiAppLauncherBox.clear();
    } catch (e) {
      throw Exception('Failed to reset Hive databases: $e');
    }
  }

  /// 重置 SQLite 数据库
  Future<void> _resetSQLiteDatabase() async {
    try {
      final database = AppDatabase();

      // 删除所有表中的数据
      await database.delete(database.aIAppConfigs).go();
      await database.delete(database.apiConfigs).go();
      await database.delete(database.promptTemplates).go();
      await database.delete(database.optimizationHistories).go();

      // 重新初始化默认数据
      final seeder = DatabaseSeeder(database.templateDao, database.apiConfigDao);
      await seeder.seedAll();

      // 重新插入默认 AI 应用配置
      for (final app in defaultAIApps) {
        await database.into(database.aIAppConfigs).insert(app);
      }
    } catch (e) {
      throw Exception('Failed to reset SQLite database: $e');
    }
  }
}
