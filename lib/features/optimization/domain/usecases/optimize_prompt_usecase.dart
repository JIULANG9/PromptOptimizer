import 'package:uuid/uuid.dart';

import '../../../api_config/data/api_config_repository.dart';
import '../../../history/data/history_repository.dart';
import '../../../history/domain/entities/history_entity.dart';
import '../../../template/data/template_repository.dart';
import '../../data/openai_api_service.dart';

/// 提示词优化核心用例
/// 编排 API 配置获取 → 模板构建 → 流式调用 → 历史保存
class OptimizePromptUseCase {
  final OpenAiApiService _apiService;
  final ApiConfigRepository _apiConfigRepo;
  final TemplateRepository _templateRepo;
  final HistoryRepository _historyRepo;

  static const _uuid = Uuid();

  OptimizePromptUseCase({
    required OpenAiApiService apiService,
    required ApiConfigRepository apiConfigRepo,
    required TemplateRepository templateRepo,
    required HistoryRepository historyRepo,
  }) : _apiService = apiService,
       _apiConfigRepo = apiConfigRepo,
       _templateRepo = templateRepo,
       _historyRepo = historyRepo;

  /// 执行优化流程，返回流式内容片段
  ///
  /// 1. 获取 API 配置并解密密钥
  /// 2. 获取模板并替换占位符
  /// 3. 调用流式 API
  /// 4. 逐 token yield
  Stream<String> execute({
    required String originalPrompt,
    required String apiConfigId,
    required String templateId,
    required String type,
  }) async* {
    // 1. 获取 API 配置
    final apiConfig = await _apiConfigRepo.getById(apiConfigId);
    if (apiConfig == null) {
      throw Exception('API configuration not found');
    }

    // 解密 API Key
    final decryptedKey = await _apiConfigRepo.getDecryptedApiKey(apiConfigId);

    // 2. 获取模板并构建 messages
    final template = await _templateRepo.getById(templateId);
    if (template == null) {
      throw Exception('Template not found');
    }

    final messages = template.buildMessages(originalPrompt);

    // 3. 调用流式 API 并逐 token 转发
    yield* _apiService.streamChatCompletion(
      baseUrl: apiConfig.baseUrl,
      modelId: apiConfig.modelId,
      apiKey: decryptedKey,
      messages: messages,
    );
  }

  /// 保存优化历史记录
  Future<void> saveHistory({
    required String originalPrompt,
    required String optimizedPrompt,
    required String type,
    required String modelKey,
    required String templateId,
  }) async {
    final history = HistoryEntity(
      id: _uuid.v4(),
      originalPrompt: originalPrompt,
      optimizedPrompt: optimizedPrompt,
      type: type,
      modelKey: modelKey,
      templateId: templateId,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await _historyRepo.create(history);
  }
}
