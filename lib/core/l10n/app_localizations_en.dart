// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Prompt Optimizer';

  @override
  String get tabUserOptimize => 'User Prompt';

  @override
  String get tabSystemOptimize => 'System Prompt';

  @override
  String get btnOptimize => 'Optimize';

  @override
  String get btnCopy => 'Copy';

  @override
  String get btnPaste => 'Paste';

  @override
  String get btnSettings => 'Settings';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnDelete => 'Delete';

  @override
  String get btnEdit => 'Edit';

  @override
  String get btnAdd => 'Add';

  @override
  String get btnClearAll => 'Clear All';

  @override
  String get btnReOptimize => 'Re-optimize';

  @override
  String get btnResetKey => 'Reset Key';

  @override
  String get btnConfirm => 'Confirm';

  @override
  String get btnFullscreen => 'Fullscreen';

  @override
  String get btnExitFullscreen => 'Exit Fullscreen';

  @override
  String get btnTest => 'Test';

  @override
  String get btnSelectProvider => 'Provider';

  @override
  String get btnSelectModel => 'Model';

  @override
  String get btnLoadingModels => 'Loading...';

  @override
  String get labelOriginalPrompt => 'Original Prompt';

  @override
  String get labelTesting => 'Testing...';

  @override
  String get labelSelectProvider => 'Select Provider';

  @override
  String get labelSelectModel => 'Select Model';

  @override
  String get labelNoModels => 'No models found';

  @override
  String labelModelCount(int count) {
    return '$count models';
  }

  @override
  String get labelOptimizedPrompt => 'Optimized Prompt';

  @override
  String get labelModelSelect => 'Model';

  @override
  String get labelTemplateSelect => 'Template';

  @override
  String get labelEnabled => 'Enabled';

  @override
  String get labelDisabled => 'Disabled';

  @override
  String get labelDefault => 'Default';

  @override
  String get labelBuiltin => 'Built-in';

  @override
  String get labelCustom => 'Custom';

  @override
  String get labelUserOptimize => 'User Prompt Optimize';

  @override
  String get labelSystemOptimize => 'System Prompt Optimize';

  @override
  String get labelAll => 'All';

  @override
  String get labelSystemRole => 'System Role Content';

  @override
  String get labelUserRole => 'User Role Content';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsModelConfig => 'Model Configuration';

  @override
  String get settingsTemplateConfig => 'Template Management';

  @override
  String get settingsHistory => 'History';

  @override
  String get settingsDataManagement => 'Data Management';

  @override
  String get settingsExportData => 'Export Data';

  @override
  String get settingsImportData => 'Import Data';

  @override
  String get settingsExportDataDesc =>
      'Export all configs, templates and history';

  @override
  String get settingsImportDataDesc => 'Restore data from backup file';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsUserAgreement => 'User Agreement';

  @override
  String get settingsOpenSource => 'Open Source Licenses';

  @override
  String get settingsJoinGroup => 'Join Discussion Group';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsWebsite => 'Official Website';

  @override
  String get settingsWebsiteDesc => 'Visit our official website';

  @override
  String get settingsContactAuthor => 'Contact Author';

  @override
  String get settingsContactEmail => 'Email';

  @override
  String get settingsContactWeChat => 'WeChat';

  @override
  String get settingsContactEmailAddress => '2021662556@qq.com';

  @override
  String get settingsContactWeChatId => 'ISSWENJIE';

  @override
  String get toastCopiedEmail => 'Email copied to clipboard';

  @override
  String get toastCopiedWeChat => 'WeChat ID copied to clipboard';

  @override
  String get toastCopiedVersion => 'Version copied to clipboard';

  @override
  String get aboutAppTitle => 'About App';

  @override
  String get aboutAppSlogan => 'Optimize Prompts, Unleash AI Potential';

  @override
  String aboutAppVersion(String version) {
    return 'v$version';
  }

  @override
  String get aboutAppOfficialWebsite => 'Official Website';

  @override
  String get aboutAppPrivacyPolicy => 'Privacy Policy';

  @override
  String get aboutAppUserAgreement => 'User Agreement';

  @override
  String get aboutAppOpenSource => 'Open Source Licenses';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'No optimization history yet';

  @override
  String get historyClearAll => 'Clear All History';

  @override
  String get historyClearConfirm =>
      'Are you sure you want to clear all history?';

  @override
  String get historyDetail => 'History Detail';

  @override
  String get apiConfigTitle => 'API Configuration';

  @override
  String get apiConfigName => 'Config Name';

  @override
  String get apiConfigBaseUrl => 'Base URL';

  @override
  String get apiConfigModelId => 'Model ID';

  @override
  String get apiConfigApiKey => 'API Key';

  @override
  String get apiConfigAdd => 'Add API Config';

  @override
  String get apiConfigEdit => 'Edit API Config';

  @override
  String get apiConfigEmpty => 'No API configurations yet';

  @override
  String get apiConfigSetDefault => 'Set as Default';

  @override
  String get apiConfigToggleEnabled => 'Toggle Enabled';

  @override
  String get apiConfigDeleteConfirm =>
      'Are you sure you want to delete this config?';

  @override
  String get apiConfigNoAvailable =>
      'No available model config, please add one';

  @override
  String get btnAddNow => 'Add Now';

  @override
  String get templateTitle => 'Template Management';

  @override
  String get templateName => 'Template Name';

  @override
  String get templateType => 'Template Type';

  @override
  String get templateContent => 'Template Content';

  @override
  String get templateDescription => 'Description';

  @override
  String get templateAdd => 'Add Template';

  @override
  String get templateEdit => 'Edit Template';

  @override
  String get templateEmpty => 'No templates yet';

  @override
  String get templateDeleteConfirm =>
      'Are you sure you want to delete this template?';

  @override
  String get templatePlaceholderHint =>
      'Use the originalPrompt placeholder for user input';

  @override
  String get errorNoApiConfig => 'Please configure an API first';

  @override
  String get errorNoTemplate => 'Please select a template';

  @override
  String errorApiCallFailed(String message) {
    return 'API call failed: $message';
  }

  @override
  String get errorEmptyPrompt => 'Please enter a prompt to optimize';

  @override
  String get errorNetworkTimeout => 'Network timeout, please try again';

  @override
  String get errorUnknown => 'An unknown error occurred';

  @override
  String get errorNameRequired => 'Name is required';

  @override
  String get errorApiKeyRequired => 'API Key is required';

  @override
  String get errorSelectProviderFirst => 'Please select a provider first';

  @override
  String errorLoadModelsFailed(String message) {
    return 'Failed to load models: $message';
  }

  @override
  String get errorBaseUrlRequired => 'Base URL is required';

  @override
  String get errorInvalidUrl => 'Please enter a valid URL';

  @override
  String get toastCopied => 'Copied to clipboard';

  @override
  String get toastSaved => 'Saved successfully';

  @override
  String get toastDeleted => 'Deleted successfully';

  @override
  String get toastOptimizing => 'Optimizing...';

  @override
  String get toastOptimizeComplete => 'Optimization complete';

  @override
  String get toastTestSuccess => 'API connection successful';

  @override
  String get toastSetDefault => 'Set as default';

  @override
  String get toastExportSuccess => 'Data exported successfully';

  @override
  String toastExportFailed(String message) {
    return 'Export failed: $message';
  }

  @override
  String get toastImportSuccess => 'Data imported successfully';

  @override
  String toastImportFailed(String message) {
    return 'Import failed: $message';
  }

  @override
  String get toastImportInvalidFile => 'Invalid backup file';

  @override
  String get toastQrCodeSaved => 'Saved to gallery';

  @override
  String get toastSaveQrCodeFailed =>
      'Save failed, please check gallery permission';

  @override
  String get themeSystem => 'Follow System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get langZh => 'Chinese';

  @override
  String get langEn => 'English';

  @override
  String get confirmDeleteTitle => 'Confirm Delete';

  @override
  String get confirmClearTitle => 'Confirm Clear';

  @override
  String get importConfirmTitle => 'Import Data';

  @override
  String get importConfirmMessage =>
      'Import will overwrite data with same ID, new data will be appended. Continue?';

  @override
  String get groupGuideText =>
      'Welcome to join our WeChat discussion group for latest updates, suggestions and feedback.';

  @override
  String get btnSaveQrCode => 'Save QR Code';

  @override
  String get promptInputHint => 'Enter or paste your prompt here...';

  @override
  String get optimizedResultHint =>
      'Optimized result will be displayed here...';

  @override
  String get onboardingProblemTitle => 'Your Prompt';

  @override
  String get onboardingProblemPrompt =>
      'Write a copy for a [Smart Portable Thermos], make it attractive.';

  @override
  String get onboardingProblemTag1 => 'Vague Requirements';

  @override
  String get onboardingProblemTag1Desc => 'No platform/audience specified';

  @override
  String get onboardingProblemTag2 => 'Missing Selling Points';

  @override
  String get onboardingProblemTag2Desc => 'Core advantages not highlighted';

  @override
  String get onboardingProblemTag3 => 'Length Uncontrolled';

  @override
  String get onboardingProblemTag3Desc => 'No word limit';

  @override
  String get onboardingUpgradeButton => 'Optimize Prompt';

  @override
  String get onboardingResultTitle => 'Optimized Copy';

  @override
  String get onboardingOptimizedPrompt =>
      'Write 3 viral promotional copies for a [Smart Portable Thermos] suitable for short videos, requirements:\n  - Youthful, visual, and conversational style\n  - Highlight three key features: 24-hour insulation, lightweight & leak-proof, high aesthetics\n  - Each within 90 words, with emotional hooks, ready to publish';

  @override
  String get onboardingProgress1 => '24h Insulation';

  @override
  String get onboardingProgress2 => 'Lightweight & Leak-proof';

  @override
  String get onboardingProgress3 => 'High Aesthetics';

  @override
  String get onboardingVideoPlatform1 => 'TikTok';

  @override
  String get onboardingVideoText1 =>
      '24h constant temp! Light enough for your bag, so pretty people ask for the link';

  @override
  String get onboardingVideoPlatform2 => 'Instagram';

  @override
  String get onboardingVideoText2 =>
      'OMG! This thermos made me love drinking water  24h insulation + gorgeous design';

  @override
  String get onboardingCtaUserCount =>
      '6396 users have improved their copy conversion rate with it';

  @override
  String get onboardingCtaButton => 'Get Started';

  @override
  String get aiAppManager => 'AI App Manager';

  @override
  String get enabledApps => 'Enabled';

  @override
  String get disabledApps => 'Disabled';

  @override
  String get addCustomApp => 'Add App';

  @override
  String get appNotInstalled => 'App not installed. Go to app store?';

  @override
  String get goDownload => 'Download';

  @override
  String get launchSuccess => 'Copied to clipboard and launched';

  @override
  String get launchFailed => 'Launch failed';

  @override
  String get searchApps => 'Search apps';

  @override
  String get addAppSuccess => 'App added successfully';

  @override
  String get addAppFailed => 'Failed to add app';

  @override
  String get deleteAppSuccess => 'App deleted successfully';

  @override
  String get deleteAppFailed => 'Failed to delete app';

  @override
  String get toggleAppFailed => 'Failed to toggle app status';

  @override
  String get updatePositionFailed => 'Failed to update app position';

  @override
  String get openStoreFailed => 'Failed to open app store';

  @override
  String get quickLaunchTitle => 'Quick Launch';

  @override
  String get debugResetDatabase => 'Reset Database (DEBUG)';

  @override
  String get debugResetDatabaseDesc =>
      'Clear all data and restore default configuration';

  @override
  String get debugResetConfirmTitle => 'Confirm Reset';

  @override
  String get debugResetConfirmMessage =>
      'This will clear all data (API configs, templates, history, etc.) and restore defaults. Continue?';

  @override
  String get debugResetSuccess => 'Database reset successfully';

  @override
  String get debugResetFailed => 'Database reset failed';
}
