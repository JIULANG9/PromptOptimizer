import '../../../../database/app_database.dart';

/// API 配置领域实体
/// 表现层和领域层通过此实体交互，不直接使用 Drift 数据类
class ApiConfigEntity {
  final String id;
  final String name;
  final String apiKey; // 加密后的密钥（存储态）或掩码（展示态）
  final String baseUrl;
  final String modelId;
  final bool isEnabled;
  final int createdAt;

  const ApiConfigEntity({
    required this.id,
    required this.name,
    required this.apiKey,
    required this.baseUrl,
    required this.modelId,
    this.isEnabled = true,
    required this.createdAt,
  });

  /// 从 Drift 数据类构造
  factory ApiConfigEntity.fromDrift(ApiConfig config) {
    return ApiConfigEntity(
      id: config.id,
      name: config.name,
      apiKey: config.apiKey,
      baseUrl: config.baseUrl,
      modelId: config.modelId,
      isEnabled: config.isEnabled,
      createdAt: config.createdAt,
    );
  }

  /// 创建副本并覆盖指定字段
  ApiConfigEntity copyWith({
    String? id,
    String? name,
    String? apiKey,
    String? baseUrl,
    String? modelId,
    bool? isEnabled,
    int? createdAt,
  }) {
    return ApiConfigEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
      modelId: modelId ?? this.modelId,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// 获取 Base URL 的截断显示（列表用）
  String get truncatedBaseUrl {
    if (baseUrl.length <= 30) return baseUrl;
    return '${baseUrl.substring(0, 30)}...';
  }
}
