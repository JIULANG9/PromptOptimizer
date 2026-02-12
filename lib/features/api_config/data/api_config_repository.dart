import 'package:drift/drift.dart';

import '../../../core/crypto/aes_crypto_service.dart';
import '../../../database/app_database.dart';
import '../../../database/daos/api_config_dao.dart';
import '../domain/entities/api_config_entity.dart';

/// API 配置仓库 — 封装 DAO 操作和加密细节
/// 领域层通过此仓库进行 CRUD，不直接访问数据库
class ApiConfigRepository {
  final ApiConfigDao _dao;
  final AesCryptoService _crypto;

  ApiConfigRepository(this._dao, this._crypto);

  /// 获取所有 API 配置
  Future<List<ApiConfigEntity>> getAll() async {
    final configs = await _dao.getAllApiConfigs();
    return configs.map(ApiConfigEntity.fromDrift).toList();
  }

  /// 监听所有 API 配置变化
  Stream<List<ApiConfigEntity>> watchAll() {
    return _dao.watchAllApiConfigs().map(
      (configs) => configs.map(ApiConfigEntity.fromDrift).toList(),
    );
  }

  /// 获取已启用的 API 配置
  Future<List<ApiConfigEntity>> getEnabled() async {
    final configs = await _dao.getEnabledApiConfigs();
    return configs.map(ApiConfigEntity.fromDrift).toList();
  }

  /// 根据 ID 获取 API 配置
  Future<ApiConfigEntity?> getById(String id) async {
    final config = await _dao.getApiConfigById(id);
    return config != null ? ApiConfigEntity.fromDrift(config) : null;
  }

  /// 获取解密后的 API Key（仅在发起 API 请求时调用）
  Future<String> getDecryptedApiKey(String id) async {
    final config = await _dao.getApiConfigById(id);
    if (config == null) throw Exception('API config not found: $id');
    return _crypto.decryptText(config.apiKey);
  }

  /// 创建新的 API 配置（API Key 自动加密）
  Future<void> create(ApiConfigEntity entity) async {
    final encryptedKey = _crypto.encryptText(entity.apiKey);
    await _dao.insertApiConfig(
      ApiConfigsCompanion.insert(
        id: entity.id,
        name: entity.name,
        apiKey: encryptedKey,
        baseUrl: Value(entity.baseUrl),
        modelId: Value(entity.modelId),
        isEnabled: Value(entity.isEnabled),
      ),
    );
  }

  /// 更新 API 配置
  /// 若 newApiKey 不为空，则加密后更新；否则保留原密钥
  Future<void> update(ApiConfigEntity entity, {String? newApiKey}) async {
    final companion = ApiConfigsCompanion(
      id: Value(entity.id),
      name: Value(entity.name),
      baseUrl: Value(entity.baseUrl),
      modelId: Value(entity.modelId),
      isEnabled: Value(entity.isEnabled),
      apiKey: newApiKey != null && newApiKey.isNotEmpty
          ? Value(_crypto.encryptText(newApiKey))
          : const Value.absent(),
    );
    await _dao.updateApiConfig(companion);
  }

  /// 删除 API 配置
  Future<void> delete(String id) async {
    await _dao.deleteApiConfig(id);
  }

  /// 切换启用/禁用状态
  Future<void> toggleEnabled(String id) async {
    final config = await _dao.getApiConfigById(id);
    if (config == null) return;
    await _dao.updateApiConfig(
      ApiConfigsCompanion(id: Value(id), isEnabled: Value(!config.isEnabled)),
    );
  }
}
