import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/l10n/app_localizations.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/domain/entities/app_settings.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/widgets/toast/toast_host.dart';

/// 应用根 Widget
/// 负责主题、国际化、路由的统一配置
/// 通过 Riverpod 监听设置变化，实现主题/语言的实时切换
class PromptOptimizerApp extends ConsumerWidget {
  const PromptOptimizerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听 state 变化以触发 rebuild（主题/语言切换）
    final appSettings = ref.watch(settingsProvider);

    // 直接从 state 计算 ThemeMode 和 Locale
    final ThemeMode themeMode;
    switch (appSettings.themeMode) {
      case ThemeModeSetting.light:
        themeMode = ThemeMode.light;
      case ThemeModeSetting.dark:
        themeMode = ThemeMode.dark;
      case ThemeModeSetting.system:
        themeMode = ThemeMode.system;
    }

    return MaterialApp.router(
      title: 'PromptOptimization',
      debugShowCheckedModeBanner: false,

      // 主题
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,

      // 国际化
      locale: Locale(appSettings.locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // 路由 + ToastHost 全局覆盖层
      routerConfig: AppRouter.router,
      builder: (context, child) => ToastHost(child: child ?? const SizedBox()),
    );
  }
}
