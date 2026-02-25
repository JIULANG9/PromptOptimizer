import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/ai_app_configs_table.dart';

part 'ai_app_config_dao.g.dart';

/// AI 应用配置数据访问对象
/// 封装 AIAppConfigs 表的所有数据库操作
@DriftAccessor(tables: [AIAppConfigs])
class AIAppConfigDao extends DatabaseAccessor<AppDatabase>
    with _$AIAppConfigDaoMixin {
  AIAppConfigDao(super.db);

  /// 获取所有 AI 应用配置
  Future<List<AIAppConfig>> getAllApps() => select(aIAppConfigs).get();

  /// 监听所有 AI 应用配置变化
  Stream<List<AIAppConfig>> watchAllApps() => select(aIAppConfigs).watch();

  /// 获取已启用的 AI 应用配置（按 position 排序）
  Future<List<AIAppConfig>> getEnabledApps() =>
      (select(aIAppConfigs)
            ..where((t) => t.isEnabled.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.position)]))
          .get();

  /// 监听已启用的 AI 应用配置（按 position 排序）
  Stream<List<AIAppConfig>> watchEnabledApps() =>
      (select(aIAppConfigs)
            ..where((t) => t.isEnabled.equals(true))
            ..orderBy([(t) => OrderingTerm.asc(t.position)]))
          .watch();

  /// 根据 ID 获取 AI 应用配置
  Future<AIAppConfig?> getAppById(String id) async {
    final results = await (select(aIAppConfigs)
          ..where((t) => t.id.equals(id)))
        .get();
    return results.isEmpty ? null : results.first;
  }

  /// 插入 AI 应用配置
  Future<void> insertApp(AIAppConfigsCompanion app) =>
      into(aIAppConfigs).insert(app);

  /// 批量插入 AI 应用配置
  Future<void> insertApps(List<AIAppConfigsCompanion> apps) async {
    await batch((batch) {
      batch.insertAll(aIAppConfigs, apps);
    });
  }

  /// 更新 AI 应用配置
  Future<bool> updateApp(AIAppConfigsCompanion app) =>
      (update(aIAppConfigs)..where((t) => t.id.equals(app.id.value)))
          .write(app)
          .then((rows) => rows > 0);

  /// 删除 AI 应用配置
  Future<int> deleteApp(String id) =>
      (delete(aIAppConfigs)..where((t) => t.id.equals(id))).go();

  /// 更新应用排序位置
  Future<bool> updateAppPosition(String id, int position) =>
      (update(aIAppConfigs)..where((t) => t.id.equals(id)))
          .write(AIAppConfigsCompanion(position: Value(position)))
          .then((rows) => rows > 0);

  /// 切换应用启用状态
  Future<bool> toggleAppEnabled(String id, bool isEnabled) =>
      (update(aIAppConfigs)..where((t) => t.id.equals(id)))
          .write(AIAppConfigsCompanion(isEnabled: Value(isEnabled)))
          .then((rows) => rows > 0);

  /// 批量更新应用排序位置
  Future<void> updateAppPositions(Map<String, int> positions) async {
    await batch((batch) {
      for (final entry in positions.entries) {
        batch.update(
          aIAppConfigs,
          AIAppConfigsCompanion(position: Value(entry.value)),
          where: (t) => t.id.equals(entry.key),
        );
      }
    });
  }

  /// 检查数据库是否为空（用于初始化判断）
  Future<bool> isEmpty() async {
    final count = await (selectOnly(aIAppConfigs)
          ..addColumns([aIAppConfigs.id.count()]))
        .getSingle();
    return count.read(aIAppConfigs.id.count()) == 0;
  }
}
