import 'package:drift/drift.dart';

import '../app_database.dart';

/// 默认 API 配置种子数据
/// 首次启动时插入内置 API 模型配置
class DefaultApiConfigs {
  DefaultApiConfigs._();

  /// 获取所有默认 API 配置数据
  static List<ApiConfigsCompanion> getAll() {
    return [
      ApiConfigsCompanion.insert(
        id: 'builtin-jl-agenapi',
        name: '限时体验',
        apiKey:
            'inryBO2bvsG81Hx85kNuFd1zWWyU9uSsL3gksrKSF2aHwXUgVi0GDd2VvCncgjnA',
        baseUrl: const Value(
          'https://agenapi.jiulang9.com/openai/v1/chat/completions',
        ),
        modelId: const Value('JL-v9-Turbo'),
        isEnabled: const Value(true),
      ),
      ApiConfigsCompanion.insert(
        id: 'builtin-aliyun-bailian',
        name: '阿里云百炼',
        apiKey: '',
        baseUrl: const Value(
          'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
        ),
        modelId: const Value('qwen-plus'),
        isEnabled: const Value(false),
      ),
      //魔搭
      ApiConfigsCompanion.insert(
        id: 'builtin-modelscope',
        name: '魔搭',
        apiKey: '',
        baseUrl: const Value(
          'https://api-inference.modelscope.cn/v1/chat/completions',
        ),
        modelId: const Value('Qwen/Qwen3-235B-A22B-Instruct-2507'),
        isEnabled: const Value(false),
      ),
      //OpenAI
      ApiConfigsCompanion.insert(
        id: 'builtin-openai',
        name: 'OpenAI',
        apiKey: '',
        baseUrl: const Value('https://api.openai.com/v1/chat/completions'),
        modelId: const Value('gpt-5'),
        isEnabled: const Value(false),
      ),
      //DeepSeek
      ApiConfigsCompanion.insert(
        id: 'builtin-deepseek',
        name: 'DeepSeek',
        apiKey: '',
        baseUrl: const Value('https://api.deepseek.ai/v1/chat/completions'),
        modelId: const Value('DeepSeek Chat'),
        isEnabled: const Value(false),
      ),
      //智普
      ApiConfigsCompanion.insert(
        id: 'builtin-zhitu',
        name: '智普',
        apiKey: '',
        baseUrl: const Value(
          'https://open.bigmodel.cn/api/paas/v4/chat/completions',
        ),
        modelId: const Value('GLM-4.7'),
        isEnabled: const Value(false),
      ),
    ];
  }
}
