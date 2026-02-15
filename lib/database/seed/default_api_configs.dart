import 'package:drift/drift.dart';

import '../app_database.dart';

/// 默认 API 配置种子数据
/// 首次启动时插入内置 API 模型配置
class DefaultApiConfigs {
  DefaultApiConfigs._();

  /// 获取所有默认 API 配置数据
  static List<ApiConfigsCompanion> getAll() {
    return [
      // JIULANG（九狼）- 限时体验
      ApiConfigsCompanion.insert(
        id: 'builtin-jiulang',
        name: 'JIULANG（九狼）- 限时体验',
        apiKey:
            'NzRgtPYsSGSIJJHmuSS/QbKBbOCO/XZDbjB79PCP02+f8MrLjNHxB/WzrILg736I',
        baseUrl: const Value(
          'https://agentapi.jiulang9.com/v1/chat/completions',
        ),
        modelId: const Value('JIULANG-v1'),
        isEnabled: const Value(true),
      ),
      // DashScope（阿里云百炼）
      ApiConfigsCompanion.insert(
        id: 'builtin-dashscope',
        name: 'DashScope（阿里云百炼）',
        apiKey: '',
        baseUrl: const Value(
          'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
        ),
        modelId: const Value('qwen-plus'),
        isEnabled: const Value(false),
      ),
      // ModelScope（魔搭）
      ApiConfigsCompanion.insert(
        id: 'builtin-modelscope',
        name: 'ModelScope（魔搭）',
        apiKey: '',
        baseUrl: const Value(
          'https://api-inference.modelscope.cn/v1/chat/completions',
        ),
        modelId: const Value('Qwen/Qwen2.5-72B-Instruct'),
        isEnabled: const Value(false),
      ),
      // OpenAI
      ApiConfigsCompanion.insert(
        id: 'builtin-openai',
        name: 'OpenAI',
        apiKey: '',
        baseUrl: const Value('https://api.openai.com/v1/chat/completions'),
        modelId: const Value('gpt-4o'),
        isEnabled: const Value(false),
      ),
      // DeepSeek
      ApiConfigsCompanion.insert(
        id: 'builtin-deepseek',
        name: 'DeepSeek',
        apiKey: '',
        baseUrl: const Value('https://api.deepseek.com/v1/chat/completions'),
        modelId: const Value('deepseek-chat'),
        isEnabled: const Value(false),
      ),
      // Moonshot AI（月之暗面）
      ApiConfigsCompanion.insert(
        id: 'builtin-moonshot',
        name: 'Moonshot AI（月之暗面）',
        apiKey: '',
        baseUrl: const Value('https://api.moonshot.cn/v1/chat/completions'),
        modelId: const Value('moonshot-v1-8k'),
        isEnabled: const Value(false),
      ),
      // Zhipu AI（智谱）
      ApiConfigsCompanion.insert(
        id: 'builtin-zhipu',
        name: 'Zhipu AI（智谱）',
        apiKey: '',
        baseUrl: const Value(
          'https://open.bigmodel.cn/api/paas/v4/chat/completions',
        ),
        modelId: const Value('glm-4'),
        isEnabled: const Value(false),
      ),
      // 文心一言
      ApiConfigsCompanion.insert(
        id: 'builtin-baidu',
        name: '文心一言',
        apiKey: '',
        baseUrl: const Value(
          'https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions',
        ),
        modelId: const Value('ernie-4.0-8k'),
        isEnabled: const Value(false),
      ),
      // Tencent（腾讯混元）
      ApiConfigsCompanion.insert(
        id: 'builtin-tencent',
        name: 'Tencent（腾讯混元）',
        apiKey: '',
        baseUrl: const Value(
          'https://hunyuan.tencentcloudapi.com/chat/completions',
        ),
        modelId: const Value('hunyuan-lite'),
        isEnabled: const Value(false),
      ),
      // OpenRouter
      ApiConfigsCompanion.insert(
        id: 'builtin-openrouter',
        name: 'OpenRouter',
        apiKey: '',
        baseUrl: const Value(
          'https://openrouter.ai/api/v1/chat/completions',
        ),
        modelId: const Value('meta-llama/llama-3.1-8b-instruct:free'),
        isEnabled: const Value(false),
      ),
    ];
  }
}
