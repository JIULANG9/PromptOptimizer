import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// 条件导入
import 'native_database.dart' if (dart.library.html) 'web_database.dart';

import 'daos/api_config_dao.dart';
import 'daos/history_dao.dart';
import 'daos/template_dao.dart';
import 'tables/api_configs_table.dart';
import 'tables/optimization_histories_table.dart';
import 'tables/prompt_templates_table.dart';

part 'app_database.g.dart';

// ═══════════════════════════════════════════════════════════════
// 数据库定义
// ═══════════════════════════════════════════════════════════════

@DriftDatabase(
  tables: [ApiConfigs, PromptTemplates, OptimizationHistories],
  daos: [ApiConfigDao, TemplateDao, HistoryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// 用于测试的构造函数，允许注入自定义 QueryExecutor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
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
    },
  );
}

/// 打开数据库连接
dynamic _openConnection() {
  if (kIsWeb) {
    // Web 平台使用内存数据库
    return WebDatabaseConnection.createConnection();
  } else {
    // 桌面和移动平台使用 SQLite 文件
    return NativeDatabaseConnection.createConnection();
  }
}
