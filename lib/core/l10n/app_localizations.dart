import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Prompt Optimizer'**
  String get appTitle;

  /// No description provided for @tabUserOptimize.
  ///
  /// In en, this message translates to:
  /// **'User Prompt'**
  String get tabUserOptimize;

  /// No description provided for @tabSystemOptimize.
  ///
  /// In en, this message translates to:
  /// **'System Prompt'**
  String get tabSystemOptimize;

  /// No description provided for @btnOptimize.
  ///
  /// In en, this message translates to:
  /// **'Optimize'**
  String get btnOptimize;

  /// No description provided for @btnCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get btnCopy;

  /// No description provided for @btnPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get btnPaste;

  /// No description provided for @btnSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get btnSettings;

  /// No description provided for @btnSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get btnSave;

  /// No description provided for @btnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btnCancel;

  /// No description provided for @btnDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get btnDelete;

  /// No description provided for @btnEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get btnEdit;

  /// No description provided for @btnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get btnAdd;

  /// No description provided for @btnClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get btnClearAll;

  /// No description provided for @btnReOptimize.
  ///
  /// In en, this message translates to:
  /// **'Re-optimize'**
  String get btnReOptimize;

  /// No description provided for @btnResetKey.
  ///
  /// In en, this message translates to:
  /// **'Reset Key'**
  String get btnResetKey;

  /// No description provided for @btnConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get btnConfirm;

  /// No description provided for @btnFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get btnFullscreen;

  /// No description provided for @btnExitFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Exit Fullscreen'**
  String get btnExitFullscreen;

  /// No description provided for @btnTest.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get btnTest;

  /// No description provided for @btnSelectProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get btnSelectProvider;

  /// No description provided for @btnSelectModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get btnSelectModel;

  /// No description provided for @btnLoadingModels.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get btnLoadingModels;

  /// No description provided for @labelOriginalPrompt.
  ///
  /// In en, this message translates to:
  /// **'Original Prompt'**
  String get labelOriginalPrompt;

  /// No description provided for @labelTesting.
  ///
  /// In en, this message translates to:
  /// **'Testing...'**
  String get labelTesting;

  /// No description provided for @labelSelectProvider.
  ///
  /// In en, this message translates to:
  /// **'Select Provider'**
  String get labelSelectProvider;

  /// No description provided for @labelSelectModel.
  ///
  /// In en, this message translates to:
  /// **'Select Model'**
  String get labelSelectModel;

  /// No description provided for @labelNoModels.
  ///
  /// In en, this message translates to:
  /// **'No models found'**
  String get labelNoModels;

  /// No description provided for @labelModelCount.
  ///
  /// In en, this message translates to:
  /// **'{count} models'**
  String labelModelCount(int count);

  /// No description provided for @labelOptimizedPrompt.
  ///
  /// In en, this message translates to:
  /// **'Optimized Prompt'**
  String get labelOptimizedPrompt;

  /// No description provided for @labelModelSelect.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get labelModelSelect;

  /// No description provided for @labelTemplateSelect.
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get labelTemplateSelect;

  /// No description provided for @labelEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get labelEnabled;

  /// No description provided for @labelDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get labelDisabled;

  /// No description provided for @labelDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get labelDefault;

  /// No description provided for @labelBuiltin.
  ///
  /// In en, this message translates to:
  /// **'Built-in'**
  String get labelBuiltin;

  /// No description provided for @labelCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get labelCustom;

  /// No description provided for @labelUserOptimize.
  ///
  /// In en, this message translates to:
  /// **'User Prompt Optimize'**
  String get labelUserOptimize;

  /// No description provided for @labelSystemOptimize.
  ///
  /// In en, this message translates to:
  /// **'System Prompt Optimize'**
  String get labelSystemOptimize;

  /// No description provided for @labelAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get labelAll;

  /// No description provided for @labelSystemRole.
  ///
  /// In en, this message translates to:
  /// **'System Role Content'**
  String get labelSystemRole;

  /// No description provided for @labelUserRole.
  ///
  /// In en, this message translates to:
  /// **'User Role Content'**
  String get labelUserRole;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsModelConfig.
  ///
  /// In en, this message translates to:
  /// **'Model Configuration'**
  String get settingsModelConfig;

  /// No description provided for @settingsTemplateConfig.
  ///
  /// In en, this message translates to:
  /// **'Template Management'**
  String get settingsTemplateConfig;

  /// No description provided for @settingsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get settingsHistory;

  /// No description provided for @settingsDataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get settingsDataManagement;

  /// No description provided for @settingsExportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settingsExportData;

  /// No description provided for @settingsImportData.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get settingsImportData;

  /// No description provided for @settingsExportDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Export all configs, templates and history'**
  String get settingsExportDataDesc;

  /// No description provided for @settingsImportDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Restore data from backup file'**
  String get settingsImportDataDesc;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsUserAgreement.
  ///
  /// In en, this message translates to:
  /// **'User Agreement'**
  String get settingsUserAgreement;

  /// No description provided for @settingsOpenSource.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get settingsOpenSource;

  /// No description provided for @settingsJoinGroup.
  ///
  /// In en, this message translates to:
  /// **'Join Discussion Group'**
  String get settingsJoinGroup;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No optimization history yet'**
  String get historyEmpty;

  /// No description provided for @historyClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All History'**
  String get historyClearAll;

  /// No description provided for @historyClearConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all history?'**
  String get historyClearConfirm;

  /// No description provided for @historyDetail.
  ///
  /// In en, this message translates to:
  /// **'History Detail'**
  String get historyDetail;

  /// No description provided for @apiConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'API Configuration'**
  String get apiConfigTitle;

  /// No description provided for @apiConfigName.
  ///
  /// In en, this message translates to:
  /// **'Config Name'**
  String get apiConfigName;

  /// No description provided for @apiConfigBaseUrl.
  ///
  /// In en, this message translates to:
  /// **'Base URL'**
  String get apiConfigBaseUrl;

  /// No description provided for @apiConfigModelId.
  ///
  /// In en, this message translates to:
  /// **'Model ID'**
  String get apiConfigModelId;

  /// No description provided for @apiConfigApiKey.
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get apiConfigApiKey;

  /// No description provided for @apiConfigAdd.
  ///
  /// In en, this message translates to:
  /// **'Add API Config'**
  String get apiConfigAdd;

  /// No description provided for @apiConfigEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit API Config'**
  String get apiConfigEdit;

  /// No description provided for @apiConfigEmpty.
  ///
  /// In en, this message translates to:
  /// **'No API configurations yet'**
  String get apiConfigEmpty;

  /// No description provided for @apiConfigSetDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as Default'**
  String get apiConfigSetDefault;

  /// No description provided for @apiConfigToggleEnabled.
  ///
  /// In en, this message translates to:
  /// **'Toggle Enabled'**
  String get apiConfigToggleEnabled;

  /// No description provided for @apiConfigDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this config?'**
  String get apiConfigDeleteConfirm;

  /// No description provided for @apiConfigNoAvailable.
  ///
  /// In en, this message translates to:
  /// **'No available model config, please add one'**
  String get apiConfigNoAvailable;

  /// No description provided for @btnAddNow.
  ///
  /// In en, this message translates to:
  /// **'Add Now'**
  String get btnAddNow;

  /// No description provided for @templateTitle.
  ///
  /// In en, this message translates to:
  /// **'Template Management'**
  String get templateTitle;

  /// No description provided for @templateName.
  ///
  /// In en, this message translates to:
  /// **'Template Name'**
  String get templateName;

  /// No description provided for @templateType.
  ///
  /// In en, this message translates to:
  /// **'Template Type'**
  String get templateType;

  /// No description provided for @templateContent.
  ///
  /// In en, this message translates to:
  /// **'Template Content'**
  String get templateContent;

  /// No description provided for @templateDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get templateDescription;

  /// No description provided for @templateAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Template'**
  String get templateAdd;

  /// No description provided for @templateEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Template'**
  String get templateEdit;

  /// No description provided for @templateEmpty.
  ///
  /// In en, this message translates to:
  /// **'No templates yet'**
  String get templateEmpty;

  /// No description provided for @templateDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this template?'**
  String get templateDeleteConfirm;

  /// No description provided for @templatePlaceholderHint.
  ///
  /// In en, this message translates to:
  /// **'Use the originalPrompt placeholder for user input'**
  String get templatePlaceholderHint;

  /// No description provided for @errorNoApiConfig.
  ///
  /// In en, this message translates to:
  /// **'Please configure an API first'**
  String get errorNoApiConfig;

  /// No description provided for @errorNoTemplate.
  ///
  /// In en, this message translates to:
  /// **'Please select a template'**
  String get errorNoTemplate;

  /// No description provided for @errorApiCallFailed.
  ///
  /// In en, this message translates to:
  /// **'API call failed: {message}'**
  String errorApiCallFailed(String message);

  /// No description provided for @errorEmptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter a prompt to optimize'**
  String get errorEmptyPrompt;

  /// No description provided for @errorNetworkTimeout.
  ///
  /// In en, this message translates to:
  /// **'Network timeout, please try again'**
  String get errorNetworkTimeout;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get errorUnknown;

  /// No description provided for @errorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get errorNameRequired;

  /// No description provided for @errorApiKeyRequired.
  ///
  /// In en, this message translates to:
  /// **'API Key is required'**
  String get errorApiKeyRequired;

  /// No description provided for @errorSelectProviderFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a provider first'**
  String get errorSelectProviderFirst;

  /// No description provided for @errorLoadModelsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load models: {message}'**
  String errorLoadModelsFailed(String message);

  /// No description provided for @errorBaseUrlRequired.
  ///
  /// In en, this message translates to:
  /// **'Base URL is required'**
  String get errorBaseUrlRequired;

  /// No description provided for @errorInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get errorInvalidUrl;

  /// No description provided for @toastCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get toastCopied;

  /// No description provided for @toastSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get toastSaved;

  /// No description provided for @toastDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully'**
  String get toastDeleted;

  /// No description provided for @toastOptimizing.
  ///
  /// In en, this message translates to:
  /// **'Optimizing...'**
  String get toastOptimizing;

  /// No description provided for @toastOptimizeComplete.
  ///
  /// In en, this message translates to:
  /// **'Optimization complete'**
  String get toastOptimizeComplete;

  /// No description provided for @toastTestSuccess.
  ///
  /// In en, this message translates to:
  /// **'API connection successful'**
  String get toastTestSuccess;

  /// No description provided for @toastSetDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get toastSetDefault;

  /// No description provided for @toastExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data exported successfully'**
  String get toastExportSuccess;

  /// No description provided for @toastExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {message}'**
  String toastExportFailed(String message);

  /// No description provided for @toastImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data imported successfully'**
  String get toastImportSuccess;

  /// No description provided for @toastImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {message}'**
  String toastImportFailed(String message);

  /// No description provided for @toastImportInvalidFile.
  ///
  /// In en, this message translates to:
  /// **'Invalid backup file'**
  String get toastImportInvalidFile;

  /// No description provided for @toastQrCodeSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to gallery'**
  String get toastQrCodeSaved;

  /// No description provided for @toastSaveQrCodeFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed, please check gallery permission'**
  String get toastSaveQrCodeFailed;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @langZh.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get langZh;

  /// No description provided for @langEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEn;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Clear'**
  String get confirmClearTitle;

  /// No description provided for @importConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importConfirmTitle;

  /// No description provided for @importConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Import will overwrite data with same ID, new data will be appended. Continue?'**
  String get importConfirmMessage;

  /// No description provided for @groupGuideText.
  ///
  /// In en, this message translates to:
  /// **'Welcome to join our WeChat discussion group for latest updates, suggestions and feedback.'**
  String get groupGuideText;

  /// No description provided for @btnSaveQrCode.
  ///
  /// In en, this message translates to:
  /// **'Save QR Code'**
  String get btnSaveQrCode;

  /// No description provided for @promptInputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter or paste your prompt here...'**
  String get promptInputHint;

  /// No description provided for @optimizedResultHint.
  ///
  /// In en, this message translates to:
  /// **'Optimized result will be displayed here...'**
  String get optimizedResultHint;

  /// No description provided for @onboardingProblemTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Prompt'**
  String get onboardingProblemTitle;

  /// No description provided for @onboardingProblemPrompt.
  ///
  /// In en, this message translates to:
  /// **'Write a copy for a [Smart Portable Thermos], make it attractive.'**
  String get onboardingProblemPrompt;

  /// No description provided for @onboardingProblemTag1.
  ///
  /// In en, this message translates to:
  /// **'Vague Requirements'**
  String get onboardingProblemTag1;

  /// No description provided for @onboardingProblemTag1Desc.
  ///
  /// In en, this message translates to:
  /// **'No platform/audience specified'**
  String get onboardingProblemTag1Desc;

  /// No description provided for @onboardingProblemTag2.
  ///
  /// In en, this message translates to:
  /// **'Missing Selling Points'**
  String get onboardingProblemTag2;

  /// No description provided for @onboardingProblemTag2Desc.
  ///
  /// In en, this message translates to:
  /// **'Core advantages not highlighted'**
  String get onboardingProblemTag2Desc;

  /// No description provided for @onboardingProblemTag3.
  ///
  /// In en, this message translates to:
  /// **'Length Uncontrolled'**
  String get onboardingProblemTag3;

  /// No description provided for @onboardingProblemTag3Desc.
  ///
  /// In en, this message translates to:
  /// **'No word limit'**
  String get onboardingProblemTag3Desc;

  /// No description provided for @onboardingUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Optimize Prompt'**
  String get onboardingUpgradeButton;

  /// No description provided for @onboardingResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimized Copy'**
  String get onboardingResultTitle;

  /// No description provided for @onboardingOptimizedPrompt.
  ///
  /// In en, this message translates to:
  /// **'Write 3 viral promotional copies for a [Smart Portable Thermos] suitable for short videos, requirements:\n  - Youthful, visual, and conversational style\n  - Highlight three key features: 24-hour insulation, lightweight & leak-proof, high aesthetics\n  - Each within 90 words, with emotional hooks, ready to publish'**
  String get onboardingOptimizedPrompt;

  /// No description provided for @onboardingProgress1.
  ///
  /// In en, this message translates to:
  /// **'24h Insulation'**
  String get onboardingProgress1;

  /// No description provided for @onboardingProgress2.
  ///
  /// In en, this message translates to:
  /// **'Lightweight & Leak-proof'**
  String get onboardingProgress2;

  /// No description provided for @onboardingProgress3.
  ///
  /// In en, this message translates to:
  /// **'High Aesthetics'**
  String get onboardingProgress3;

  /// No description provided for @onboardingVideoPlatform1.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get onboardingVideoPlatform1;

  /// No description provided for @onboardingVideoText1.
  ///
  /// In en, this message translates to:
  /// **'24h constant temp! Light enough for your bag, so pretty people ask for the link'**
  String get onboardingVideoText1;

  /// No description provided for @onboardingVideoPlatform2.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get onboardingVideoPlatform2;

  /// No description provided for @onboardingVideoText2.
  ///
  /// In en, this message translates to:
  /// **'OMG! This thermos made me love drinking water  24h insulation + gorgeous design'**
  String get onboardingVideoText2;

  /// No description provided for @onboardingCtaUserCount.
  ///
  /// In en, this message translates to:
  /// **'6396 users have improved their copy conversion rate with it'**
  String get onboardingCtaUserCount;

  /// No description provided for @onboardingCtaButton.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingCtaButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
