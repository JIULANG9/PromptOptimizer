import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/settings_repository.dart';
import '../../domain/entities/app_settings.dart';

/// 设置状态 Notifier（MVI Intent 处理器）
class SettingsNotifier extends Notifier<AppSettings> {
  late SettingsRepository _repository;

  @override
  AppSettings build() {
    _repository = ref.watch(settingsRepositoryProvider);
    // T3.3: 全局主题/语言状态，不应被自动暂停
    ref.keepAlive();
    return _repository.getSettings();
  }

  /// Intent: 切换主题模式
  Future<void> setThemeMode(ThemeModeSetting mode) async {
    await _repository.saveThemeMode(mode);
    state = state.copyWith(themeMode: mode);
  }

  /// Intent: 切换语言
  Future<void> setLocale(String locale) async {
    await _repository.saveLocale(locale);
    state = state.copyWith(locale: locale);
  }

  /// 将 ThemeModeSetting 转换为 Flutter ThemeMode
  ThemeMode get flutterThemeMode {
    switch (state.themeMode) {
      case ThemeModeSetting.light:
        return ThemeMode.light;
      case ThemeModeSetting.dark:
        return ThemeMode.dark;
      case ThemeModeSetting.system:
        return ThemeMode.system;
    }
  }

  /// 获取当前 Locale
  Locale get currentLocale => Locale(state.locale);
}

// ─── Providers ───

/// Hive Settings Box Provider（由 main.dart 中 ProviderScope override 注入）
final settingsBoxProvider = Provider<Box>((ref) {
  throw UnimplementedError('settingsBoxProvider must be overridden');
});

/// 设置仓库 Provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(settingsBoxProvider));
}, dependencies: [settingsBoxProvider]);

/// 设置状态 Provider
final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
  dependencies: [settingsRepositoryProvider, settingsBoxProvider],
);
