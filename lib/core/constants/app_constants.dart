/// 应用全局常量定义
/// 所有硬编码值统一在此管理，禁止在业务代码中直接使用魔法字符串
class AppConstants {
  AppConstants._();

  // ─── Hive 存储 ───
  /// Hive Box 名称，用于存储 UI 偏好设置（主题、语言）
  static const String settingsBoxName = 'app_settings_ui';

  /// Hive Box 名称，用于存储 AI 应用启动器折叠状态
  static const String aiAppLauncherBoxName = 'ai_app_launcher_state';

  /// AI 应用启动器折叠状态的 Key
  static const String aiAppLauncherCollapsedKey = 'is_collapsed';

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

  // ─── AI 应用深度跳转 ───
  /// 内置 AI 应用配置（硬编码，方便后期调整）
  static const List<Map<String, String>> builtInAIApps = [

    {
      'name': '通义千问',
      'scheme': 'tongyi://',
      'iconPath': 'assets/icon/icon_tongyi_qianwen.svg',
      'packageName': 'com.aliyun.tongyi', // 通义千问Android包名
    },
    {
      'name': 'Qwen Chat',
      'scheme': 'qwen://',
      'iconPath': 'assets/icon/icon_tongyi_qianwen.svg',
      'packageName': 'com.aliyun.tongyi', // 通义千问Android包名
    },
    {
      'name': 'Kimi',
      'scheme': 'kimi://',
      'iconPath': 'assets/icon/icon_kimi.svg',
      'packageName': 'com.moonshot.kimi', // Kimi智能助手Android包名
    },
    {
      'name': '豆包',
      'scheme': 'doubao://',
      'iconPath': 'assets/icon/icon_doubao.svg',
      'packageName': 'com.larus.nova', // 豆包Android包名
    },
    {
      'name': 'DeepSeek',
      'scheme': 'dpsk://chat/new',
      'iconPath': 'assets/icon/icon_deepseek.svg',
      'packageName': 'com.deepseek.chat', // DeepSeekAndroid包名
    },
    {
      'name': '元宝',
      'scheme': 'hunyuan://chat',
      'iconPath': 'assets/icon/icon_tencent_yuanbao.svg',
      'packageName': 'com.tencent.hunyuan.app.chat', // 腾讯元宝Android包名
    },
    {
      'name': '文心一言',
      'scheme': 'baiduwanhua://',
      'iconPath': 'assets/icon/icon_wenxinyiyan.svg',
      'packageName': 'com.baidu.newapp', // 文心一言Android包名
    },
    {
      'name': '讯飞星火',
      'scheme': 'sparkdesk://',
      'iconPath': 'assets/icon/icon_xunfei_xinghuo.svg',
      'packageName': 'com.iflytek.spark', // 讯飞星火Android包名
    },
     {
       'name': '智谱AI',
       'scheme': 'zhipuai://',
       'iconPath': 'assets/icon/icom.zhipu.svg',
       'packageName': 'com.zhipuai.qingyang', // 智谱AIAndroid包名
     }
  ];
}
