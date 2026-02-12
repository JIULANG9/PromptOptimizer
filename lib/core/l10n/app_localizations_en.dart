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
  String get optimizedResultHint => 'Optimized result will appear here...';
}
