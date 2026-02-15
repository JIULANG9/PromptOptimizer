import 'package:dio/dio.dart';

/// 模型提供商枚举
enum ModelProvider {
  dashScope(
    'DashScope (阿里云百炼)',
    'https://dashscope.aliyuncs.com/compatible-mode/v1',
  ),
  modelScope('ModelScope (魔搭)', 'https://api-inference.modelscope.cn/v1'),
  openAI('OpenAI', 'https://api.openai.com/v1'),
  deepSeek('DeepSeek', 'https://api.deepseek.com/v1'),
  moonshot('Moonshot AI（月之暗面）', 'https://api.moonshot.cn/v1'),
  zhipu('Zhipu AI（智谱）', 'https://open.bigmodel.cn/api/paas/v4'),
  jiulang('JIULANG（九狼）', 'https://agentapi.jiulang9.com/v1'),
  baidu('文心一言', 'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop'),
  tencent('Tencent', 'https://hunyuan.tencentcloudapi.com'),
  openRouter('OpenRouter', 'https://openrouter.ai/api/v1');

  final String displayName;
  final String baseUrl;

  const ModelProvider(this.displayName, this.baseUrl);

  /// 获取模型列表的完整 URL
  String get modelsUrl => '$baseUrl/models';
  
  /// 根据 baseUrl 智能匹配提供商
  /// 返回匹配的提供商，如果没有匹配则返回 null
  static ModelProvider? matchFromUrl(String url) {
    if (url.isEmpty) return null;
    
    final normalizedUrl = url.toLowerCase().trim();
    
    for (final provider in ModelProvider.values) {
      final providerBaseUrl = provider.baseUrl.toLowerCase();
      // 检查 URL 是否包含提供商的基础 URL
      if (normalizedUrl.contains(providerBaseUrl) ||
          providerBaseUrl.contains(normalizedUrl)) {
        return provider;
      }
      
      // 提取域名进行匹配
      final providerDomain = _extractDomain(providerBaseUrl);
      final inputDomain = _extractDomain(normalizedUrl);
      
      if (providerDomain.isNotEmpty && 
          inputDomain.isNotEmpty && 
          providerDomain == inputDomain) {
        return provider;
      }
    }
    
    return null;
  }
  
  /// 提取 URL 中的主域名
  static String _extractDomain(String url) {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) return '';
      
      final host = uri.host.toLowerCase();
      // 移除 www. 前缀
      return host.startsWith('www.') ? host.substring(4) : host;
    } catch (_) {
      return '';
    }
  }
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
