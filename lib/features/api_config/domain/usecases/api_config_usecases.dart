import '../../data/api_config_repository.dart';
import '../entities/api_config_entity.dart';

/// API 配置用例 — 纯业务逻辑，无 Flutter 依赖
/// Notifier 通过此用例执行业务操作
class ApiConfigUseCases {
  final ApiConfigRepository _repository;

  ApiConfigUseCases(this._repository);

  /// 获取所有配置
  Future<List<ApiConfigEntity>> getAll() => _repository.getAll();

  /// 监听所有配置变化
  Stream<List<ApiConfigEntity>> watchAll() => _repository.watchAll();

  /// 获取已启用的配置
  Future<List<ApiConfigEntity>> getEnabled() => _repository.getEnabled();

  /// 根据 ID 获取配置
  Future<ApiConfigEntity?> getById(String id) => _repository.getById(id);

  /// 创建新配置
  Future<void> create(ApiConfigEntity entity) => _repository.create(entity);

  /// 更新配置（可选更新 API Key）
  Future<void> update(ApiConfigEntity entity, {String? newApiKey}) =>
      _repository.update(entity, newApiKey: newApiKey);

  /// 删除配置
  Future<void> delete(String id) => _repository.delete(id);

  /// 切换启用/禁用
  Future<void> toggleEnabled(String id) => _repository.toggleEnabled(id);

  /// 获取解密后的 API Key（仅用于发起请求）
  Future<String> getDecryptedApiKey(String id) =>
      _repository.getDecryptedApiKey(id);
}
