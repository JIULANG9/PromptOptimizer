/// 导出数据实体 — 表示完整的应用备份数据
/// 用于 Domain 层和 Data 层之间的数据传递
class ExportData {
  /// 数据格式版本号，用于未来兼容性处理
  final int version;

  /// 应用版本号
  final String appVersion;

  /// 导出时间戳（毫秒）
  final int exportedAt;

  /// API 配置列表（保持加密态 apiKey）
  final List<Map<String, dynamic>> apiConfigs;

  /// 模板列表
  final List<Map<String, dynamic>> templates;

  /// 历史记录列表
  final List<Map<String, dynamic>> histories;

  /// 选中状态设置
  final Map<String, String?> settings;

  const ExportData({
    this.version = 1,
    this.appVersion = '1.0.0',
    required this.exportedAt,
    required this.apiConfigs,
    required this.templates,
    required this.histories,
    required this.settings,
  });

  /// 序列化为 JSON Map
  Map<String, dynamic> toJson() => {
    'version': version,
    'appVersion': appVersion,
    'exportedAt': exportedAt,
    'data': {
      'apiConfigs': apiConfigs,
      'templates': templates,
      'histories': histories,
      'settings': settings,
    },
  };

  /// 从 JSON Map 反序列化
  /// 抛出 FormatException 如果格式无效
  factory ExportData.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('version') || !json.containsKey('data')) {
      throw const FormatException('Invalid backup file format');
    }

    final data = json['data'] as Map<String, dynamic>;

    return ExportData(
      version: json['version'] as int? ?? 1,
      appVersion: json['appVersion'] as String? ?? 'unknown',
      exportedAt: json['exportedAt'] as int? ?? 0,
      apiConfigs:
          (data['apiConfigs'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [],
      templates:
          (data['templates'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [],
      histories:
          (data['histories'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [],
      settings: Map<String, String?>.from(
        (data['settings'] as Map<String, dynamic>?) ?? {},
      ),
    );
  }
}
