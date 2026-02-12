import 'package:dio/dio.dart';

/// 模型提供商枚举
enum ModelProvider {
  dashScope(
    'DashScope (阿里云百炼)',
    'https://dashscope.aliyuncs.com/compatible-mode/v1',
  ),
  modelScope('ModelScope (魔搭)', 'https://api-inference.modelscope.cn/v1'),
  openAI('OpenAI', 'https://api.openai.com/v1');

  final String displayName;
  final String baseUrl;

  const ModelProvider(this.displayName, this.baseUrl);

  /// 获取模型列表的完整 URL
  String get modelsUrl => '$baseUrl/models';
}

/// 模型信息
class ModelInfo {
  final String id;
  final String ownedBy;

  const ModelInfo({required this.id, this.ownedBy = ''});
}

/// 模型提供商服务 — 负责从各提供商 API 获取模型列表
class ModelProviderService {
  final Dio _dio = Dio();

  /// 根据提供商和 API Key 获取模型列表
  /// 返回模型 ID 列表，按字母排序
  Future<List<ModelInfo>> fetchModels({
    required ModelProvider provider,
    required String apiKey,
  }) async {
    final response = await _dio.get(
      provider.modelsUrl,
      options: Options(
        headers: {'Authorization': 'Bearer $apiKey'},
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> modelList = data['data'] ?? [];

      final models = modelList
          .map(
            (m) => ModelInfo(
              id: m['id']?.toString() ?? '',
              ownedBy: m['owned_by']?.toString() ?? '',
            ),
          )
          .where((m) => m.id.isNotEmpty)
          .toList();

      // 按模型 ID 字母排序
      models.sort((a, b) => a.id.compareTo(b.id));
      return models;
    }

    throw Exception('HTTP ${response.statusCode}');
  }
}
