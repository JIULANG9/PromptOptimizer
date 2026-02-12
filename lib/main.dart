import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'database/app_database.dart';
import 'database/seed/database_seeder.dart';
import 'features/api_config/presentation/providers/api_config_provider.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

/// 应用入口
/// 初始化顺序: Hive → Database → 默认模板 → ProviderScope → App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 初始化 Hive（使用应用专属子目录，避免 lock 冲突）
  final appDocDir = await getApplicationSupportDirectory();
  final hivePath = '${appDocDir.path}${Platform.pathSeparator}hive_data';

  // 清理旧的 lock 文件（如果存在）
  try {
    final hiveDir = Directory(hivePath);
    if (await hiveDir.exists()) {
      final lockFiles = hiveDir.listSync().where(
        (f) => f.path.endsWith('.lock'),
      );
      for (final lockFile in lockFiles) {
        try {
          await File(lockFile.path).delete();
        } catch (e) {
          // 忽略删除失败，继续初始化
        }
      }
    }
  } catch (e) {
    // 忽略清理错误
  }

  await Directory(hivePath).create(recursive: true);
  Hive.init(hivePath);
  final settingsBox = await Hive.openBox(AppConstants.settingsBoxName);

  // 2. 初始化 Drift 数据库
  final database = AppDatabase();

  // 3. 插入默认数据（首次启动时）
  final seeder = DatabaseSeeder(database.templateDao, database.apiConfigDao);
  await seeder.seedAll();

  // 4. 启动应用，通过 ProviderScope overrides 注入依赖
  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        settingsBoxProvider.overrideWithValue(settingsBox),
      ],
      child: const PromptOptimizerApp(),
    ),
  );
}
