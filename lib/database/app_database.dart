import 'package:drift/drift.dart';

import 'connection/open_connection.dart';

import 'daos/ai_app_config_dao.dart';
import 'daos/api_config_dao.dart';
import 'daos/history_dao.dart';
import 'daos/template_dao.dart';
import 'seed/default_ai_apps.dart';
import 'tables/ai_app_configs_table.dart';
import 'tables/api_configs_table.dart';
import 'tables/optimization_histories_table.dart';
import 'tables/prompt_templates_table.dart';

part 'app_database.g.dart';

// ═══════════════════════════════════════════════════════════════
// 数据库定义
// ═══════════════════════════════════════════════════════════════

@DriftDatabase(
  tables: [AIAppConfigs, ApiConfigs, PromptTemplates, OptimizationHistories],
  daos: [AIAppConfigDao, ApiConfigDao, TemplateDao, HistoryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// 用于测试的构造函数，允许注入自定义 QueryExecutor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // 全新安装时插入默认 AI 应用配置
      for (final app in defaultAIApps) {
        await into(aIAppConfigs).insert(app);
      }
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // v1 -> v2: 添加 ApiConfigs.createdAt 字段
      if (from < 2) {
        await m.addColumn(apiConfigs, apiConfigs.createdAt);
      }
      // v2 -> v3: 删除 ApiConfigs.isDefault 字段
      if (from < 3) {
        await customStatement('ALTER TABLE api_configs DROP COLUMN is_default');
      }
      // v3 -> v4: 创建 AIAppConfigs 表并插入默认应用
      if (from < 4) {
        await m.createTable(aIAppConfigs);
        // 插入默认 AI 应用配置
        for (final app in defaultAIApps) {
          await into(aIAppConfigs).insert(app);
        }
      }
    },
  );
}

/// 打开数据库连接
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return await openExecutor();
  });
}
