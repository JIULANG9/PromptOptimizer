// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '提示词优化器';

  @override
  String get tabUserOptimize => '用户提示词';

  @override
  String get tabSystemOptimize => '系统提示词';

  @override
  String get btnOptimize => '优化';

  @override
  String get btnCopy => '复制';

  @override
  String get btnPaste => '粘贴';

  @override
  String get btnSettings => '设置';

  @override
  String get btnSave => '保存';

  @override
  String get btnCancel => '取消';

  @override
  String get btnDelete => '删除';

  @override
  String get btnEdit => '编辑';

  @override
  String get btnAdd => '添加';

  @override
  String get btnClearAll => '清空';

  @override
  String get btnReOptimize => '重新优化';

  @override
  String get btnResetKey => '重置密钥';

  @override
  String get btnConfirm => '确认';

  @override
  String get btnFullscreen => '全屏';

  @override
  String get btnExitFullscreen => '退出全屏';

  @override
  String get btnTest => '测试';

  @override
  String get btnSelectProvider => '提供商';

  @override
  String get btnSelectModel => '模型';

  @override
  String get btnLoadingModels => '加载中...';

  @override
  String get labelOriginalPrompt => '原始提示词';

  @override
  String get labelTesting => '测试中...';

  @override
  String get labelSelectProvider => '选择提供商';

  @override
  String get labelSelectModel => '选择模型';

  @override
  String get labelNoModels => '未找到模型';

  @override
  String labelModelCount(int count) {
    return '$count 个模型';
  }

  @override
  String get labelOptimizedPrompt => '优化后提示词';

  @override
  String get labelModelSelect => '模型';

  @override
  String get labelTemplateSelect => '模板';

  @override
  String get labelEnabled => '已启用';

  @override
  String get labelDisabled => '已禁用';

  @override
  String get labelDefault => '默认';

  @override
  String get labelBuiltin => '内置';

  @override
  String get labelCustom => '自定义';

  @override
  String get labelUserOptimize => '用户提示词优化';

  @override
  String get labelSystemOptimize => '系统提示词优化';

  @override
  String get labelAll => '全部';

  @override
  String get labelSystemRole => '系统角色内容';

  @override
  String get labelUserRole => '用户角色内容';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsModelConfig => '模型配置';

  @override
  String get settingsTemplateConfig => '模板管理';

  @override
  String get settingsHistory => '历史记录';

  @override
  String get settingsDataManagement => '数据管理';

  @override
  String get settingsExportData => '导出数据';

  @override
  String get settingsImportData => '导入数据';

  @override
  String get settingsExportDataDesc => '导出所有配置、模板和历史记录';

  @override
  String get settingsImportDataDesc => '从备份文件恢复数据';

  @override
  String get settingsAboutSection => '关于应用';

  @override
  String get settingsPrivacyPolicy => '隐私政策';

  @override
  String get settingsUserAgreement => '用户协议';

  @override
  String get settingsOpenSource => '开源协议';

  @override
  String get settingsJoinGroup => '加入交流群';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsTheme => '主题';

  @override
  String get settingsWebsite => '官方网站';

  @override
  String get settingsWebsiteDesc => '访问我们的官方网站';

  @override
  String get settingsContactAuthor => '联系作者';

  @override
  String get settingsContactEmail => '邮箱';

  @override
  String get settingsContactWeChat => '微信';

  @override
  String get settingsContactEmailAddress => '2021662556@qq.com';

  @override
  String get settingsContactWeChatId => 'ISSWENJIE';

  @override
  String get toastCopiedEmail => '邮箱已复制到剪贴板';

  @override
  String get toastCopiedWeChat => '微信号已复制到剪贴板';

  @override
  String get toastCopiedVersion => '版本号已复制到剪贴板';

  @override
  String get aboutAppTitle => '关于应用';

  @override
  String get aboutAppSlogan => '优化提示词释放 AI 潜能';

  @override
  String aboutAppVersion(String version) {
    return 'v$version';
  }

  @override
  String get aboutAppOfficialWebsite => '官方网址';

  @override
  String get aboutAppPrivacyPolicy => '隐私政策';

  @override
  String get aboutAppUserAgreement => '用户协议';

  @override
  String get aboutAppOpenSource => '开源协议';

  @override
  String get historyTitle => '历史记录';

  @override
  String get historyEmpty => '暂无优化历史';

  @override
  String get historyClearAll => '清空所有历史';

  @override
  String get historyClearConfirm => '确定要清空所有历史记录吗？';

  @override
  String get historyDetail => '历史详情';

  @override
  String get apiConfigTitle => 'API 配置';

  @override
  String get apiConfigName => '配置名称';

  @override
  String get apiConfigBaseUrl => '基础地址';

  @override
  String get apiConfigModelId => '模型 ID';

  @override
  String get apiConfigApiKey => 'API 密钥';

  @override
  String get apiConfigAdd => '添加 API 配置';

  @override
  String get apiConfigEdit => '编辑 API 配置';

  @override
  String get apiConfigEmpty => '暂无 API 配置';

  @override
  String get apiConfigSetDefault => '设为默认';

  @override
  String get apiConfigToggleEnabled => '切换启用状态';

  @override
  String get apiConfigDeleteConfirm => '确定要删除此配置吗？';

  @override
  String get apiConfigNoAvailable => '暂无可选模型配置，请添加';

  @override
  String get btnAddNow => '立即添加';

  @override
  String get templateTitle => '模板管理';

  @override
  String get templateName => '模板名称';

  @override
  String get templateType => '模板类型';

  @override
  String get templateContent => '模板内容';

  @override
  String get templateDescription => '描述';

  @override
  String get templateAdd => '添加模板';

  @override
  String get templateEdit => '编辑模板';

  @override
  String get templateEmpty => '暂无模板';

  @override
  String get templateDeleteConfirm => '确定要删除此模板吗？';

  @override
  String get templatePlaceholderHint => '使用 originalPrompt 占位符代表用户输入';

  @override
  String get errorNoApiConfig => '请先配置 API';

  @override
  String get errorNoTemplate => '请选择模板';

  @override
  String errorApiCallFailed(String message) {
    return 'API 调用失败：$message';
  }

  @override
  String get errorEmptyPrompt => '请输入需要优化的提示词';

  @override
  String get errorNetworkTimeout => '网络超时，请重试';

  @override
  String get errorUnknown => '发生未知错误';

  @override
  String get errorNameRequired => '名称不能为空';

  @override
  String get errorApiKeyRequired => 'API 密钥不能为空';

  @override
  String get errorSelectProviderFirst => '请先选择提供商';

  @override
  String errorLoadModelsFailed(String message) {
    return '加载模型失败：$message';
  }

  @override
  String get errorBaseUrlRequired => '基础地址不能为空';

  @override
  String get errorInvalidUrl => '请输入有效的 URL';

  @override
  String get toastCopied => '已复制到剪贴板';

  @override
  String get toastSaved => '保存成功';

  @override
  String get toastDeleted => '删除成功';

  @override
  String get toastOptimizing => '正在优化...';

  @override
  String get toastOptimizeComplete => '优化完成';

  @override
  String get toastTestSuccess => 'API 连接成功';

  @override
  String get toastSetDefault => '已设为默认';

  @override
  String get toastExportSuccess => '数据导出成功';

  @override
  String toastExportFailed(String message) {
    return '导出失败：$message';
  }

  @override
  String get toastImportSuccess => '数据导入成功';

  @override
  String toastImportFailed(String message) {
    return '导入失败：$message';
  }

  @override
  String get toastImportInvalidFile => '无效的备份文件';

  @override
  String get toastQrCodeSaved => '已保存到相册';

  @override
  String get toastSaveQrCodeFailed => '保存失败，请检查相册权限';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get langZh => '中文';

  @override
  String get langEn => '英语';

  @override
  String get confirmDeleteTitle => '确认删除';

  @override
  String get confirmClearTitle => '确认清空';

  @override
  String get importConfirmTitle => '导入数据';

  @override
  String get importConfirmMessage => '导入将覆盖同 ID 数据，新数据将追加。确定继续？';

  @override
  String get groupGuideText => '欢迎加入我们的微信交流群，获取最新资讯、提交建议与反馈。';

  @override
  String get btnSaveQrCode => '保存二维码';

  @override
  String get promptInputHint => '在此输入或粘贴您的提示词...';

  @override
  String get optimizedResultHint => '优化结果将在此显示...';

  @override
  String get onboardingProblemTitle => '你的提示词';

  @override
  String get onboardingProblemPrompt => '请为一款【智能便携保温杯】写文案,要吸引人一点。';

  @override
  String get onboardingProblemTag1 => '需求模糊';

  @override
  String get onboardingProblemTag1Desc => '未指定平台/人群';

  @override
  String get onboardingProblemTag2 => '卖点缺失';

  @override
  String get onboardingProblemTag2Desc => '未突出核心优势';

  @override
  String get onboardingProblemTag3 => '长度失控';

  @override
  String get onboardingProblemTag3Desc => '无字数限制';

  @override
  String get onboardingUpgradeButton => '提示词优化';

  @override
  String get onboardingResultTitle => '优化后文案';

  @override
  String get onboardingOptimizedPrompt =>
      '请为一款【智能便携保温杯】撰写 3 条适合短视频的爆款推广文案，要求：\n  - 风格年轻化、有画面感、口语化\n  - 突出 24 小时长效保温、轻便防漏、颜值高三大卖点\n  - 每条控制在 90 字以内，自带情绪钩子，适合直接发布';

  @override
  String get onboardingProgress1 => '24小时长效保温';

  @override
  String get onboardingProgress2 => '轻便防漏';

  @override
  String get onboardingProgress3 => '颜值高';

  @override
  String get onboardingVideoPlatform1 => '抖音';

  @override
  String get onboardingVideoText1 => '24h恒温锁鲜!轻到能放包里,颜值高到被追着问链接🔥';

  @override
  String get onboardingVideoPlatform2 => '小红书';

  @override
  String get onboardingVideoText2 => '救命!这个保温杯让我爱上喝水✨ 24h保温+高颜值';

  @override
  String get onboardingCtaUserCount => '已有 6396 位用户用它提升文案转化率';

  @override
  String get onboardingCtaButton => '开始体验';
}
