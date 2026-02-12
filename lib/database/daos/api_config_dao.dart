import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/api_configs_table.dart';

part 'api_config_dao.g.dart';

/// API 配置数据访问对象
/// 封装 ApiConfigs 表的所有数据库操作
@DriftAccessor(tables: [ApiConfigs])
class ApiConfigDao extends DatabaseAccessor<AppDatabase>
    with _$ApiConfigDaoMixin {
  ApiConfigDao(super.db);

  /// 获取所有 API 配置
  Future<List<ApiConfig>> getAllApiConfigs() => select(apiConfigs).get();

  /// 监听所有 API 配置变化
  Stream<List<ApiConfig>> watchAllApiConfigs() => select(apiConfigs).watch();

  /// 获取已启用的 API 配置
  Future<List<ApiConfig>> getEnabledApiConfigs() =>
      (select(apiConfigs)..where((t) => t.isEnabled.equals(true))).get();

  /// 根据 ID 获取 API 配置
  Future<ApiConfig?> getApiConfigById(String id) async {
    final results = await (select(
      apiConfigs,
    )..where((t) => t.id.equals(id))).get();
    return results.isEmpty ? null : results.first;
  }

  /// 插入 API 配置
  Future<void> insertApiConfig(ApiConfigsCompanion config) =>
      into(apiConfigs).insert(config);

  /// 更新 API 配置
  Future<bool> updateApiConfig(ApiConfigsCompanion config) =>
      (update(apiConfigs)..where((t) => t.id.equals(config.id.value)))
          .write(config)
          .then((rows) => rows > 0);

  /// 删除 API 配置
  Future<int> deleteApiConfig(String id) =>
      (delete(apiConfigs)..where((t) => t.id.equals(id))).go();
}
