/// 应用全局常量定义
/// 所有硬编码值统一在此管理，禁止在业务代码中直接使用魔法字符串
class AppConstants {
  AppConstants._();

  // ─── Hive 存储 ───
  /// Hive Box 名称，用于存储 UI 偏好设置（主题、语言）
  static const String settingsBoxName = 'app_settings_ui';

  // ─── 默认 API 配置 ───
  /// 默认 API 基地址（阿里云 DashScope 兼容模式）
  static const String defaultBaseUrl =
      'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions';

  /// 默认模型 ID
  static const String defaultModelId = 'qwen-plus-2025-12-01';

  /// 默认 API 配置名称
  static const String defaultApiConfigName = '我的千问';

  // ─── 加密 ───
  /// AES-256 加密密钥标识（用于密钥派生，非明文密钥）
  static const String encryptionKeyIdentifier = 'prompt_optimizer_aes_key_v1';

  /// AES 密钥长度（256位 = 32字节）
  static const int aesKeyLength = 32;

  /// AES IV 长度（128位 = 16字节）
  static const int aesIvLength = 16;

  // ─── 模板 ───
  /// 模板中原始提示词占位符
  static const String templatePlaceholder = '{{originalPrompt}}';

  /// 模板类型：用户提示词优化
  static const String templateTypeUser = 'userOptimize';

  /// 模板类型：系统提示词优化
  static const String templateTypeSystem = 'systemOptimize';

  // ─── 网络请求 ───
  /// API 请求超时时间（秒）
  static const int apiTimeoutSeconds = 60;

  /// SSE 流式响应结束标记
  static const String sseEndSignal = '[DONE]';

  // ─── UI ───
  /// 桌面端双栏布局断点宽度
  static const double desktopBreakpoint = 768.0;

  /// 提示词摘要最大长度
  static const int promptSummaryMaxLength = 50;
}
