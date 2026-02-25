import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/dialogs/animated_dialog.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/item/ripple_list_tile.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../domain/entities/app_settings.dart';
import '../providers/data_transfer_provider.dart';
import '../providers/database_reset_provider.dart';
import '../providers/settings_provider.dart';

/// 设置页面
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsProvider);

    return GlassScaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ─── 配置管理 ───
          _SectionHeader(title: l10n.settingsModelConfig),
          const SizedBox(height: 8),
          RippleSection(
            children: [
              RippleListTile(
                leading: const Icon(Icons.smart_toy_outlined),
                title: l10n.settingsModelConfig,
                showArrow: true,
                onTap: () => context.push(AppRouter.apiConfigList),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.description_outlined),
                title: l10n.settingsTemplateConfig,
                showArrow: true,
                onTap: () => context.push(AppRouter.templateList),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.apps),
                title: l10n.aiAppManager,
                showArrow: true,
                onTap: () => context.push(AppRouter.aiAppManager),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ─── 外观 ───
          _SectionHeader(title: l10n.settingsTheme),
          const SizedBox(height: 8),
          RippleSection(
            children: [
              // 主题颜色 — 展开卡片
              RippleExpansionTile(
                leading: const Icon(Icons.palette_outlined),
                title: l10n.settingsTheme,
                subtitle: _themeLabel(settings.themeMode, l10n),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      children: [
                        _ThemeCard(
                          icon: Icons.wb_sunny_outlined,
                          label: l10n.themeLight,
                          isSelected:
                              settings.themeMode == ThemeModeSetting.light,
                          onTap: () => ref
                              .read(settingsProvider.notifier)
                              .setThemeMode(ThemeModeSetting.light),
                        ),
                        const SizedBox(width: 12),
                        _ThemeCard(
                          icon: Icons.phone_android_outlined,
                          label: l10n.themeSystem,
                          isSelected:
                              settings.themeMode == ThemeModeSetting.system,
                          onTap: () => ref
                              .read(settingsProvider.notifier)
                              .setThemeMode(ThemeModeSetting.system),
                        ),
                        const SizedBox(width: 12),
                        _ThemeCard(
                          icon: Icons.dark_mode_outlined,
                          label: l10n.themeDark,
                          isSelected:
                              settings.themeMode == ThemeModeSetting.dark,
                          onTap: () => ref
                              .read(settingsProvider.notifier)
                              .setThemeMode(ThemeModeSetting.dark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              // 语言 — 展开卡片
              RippleExpansionTile(
                leading: const Icon(Icons.language_outlined),
                title: l10n.settingsLanguage,
                subtitle: settings.locale == 'zh' ? l10n.langZh : l10n.langEn,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      children: [
                        _ThemeCard(
                          icon: Icons.translate,
                          label: l10n.langZh,
                          isSelected: settings.locale == 'zh',
                          onTap: () => ref
                              .read(settingsProvider.notifier)
                              .setLocale('zh'),
                        ),
                        const SizedBox(width: 12),
                        _ThemeCard(
                          icon: Icons.abc,
                          label: l10n.langEn,
                          isSelected: settings.locale == 'en',
                          onTap: () => ref
                              .read(settingsProvider.notifier)
                              .setLocale('en'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ─── 历史记录 ───
          _SectionHeader(title: l10n.settingsHistory),
          const SizedBox(height: 8),
          RippleSection(
            children: [
              RippleListTile(
                leading: const Icon(Icons.history_outlined),
                title: l10n.settingsHistory,
                showArrow: true,
                onTap: () => context.push(AppRouter.historyList),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ─── 数据管理 ───
          _SectionHeader(title: l10n.settingsDataManagement),
          const SizedBox(height: 8),
          RippleSection(
            children: [
              RippleListTile(
                leading: const Icon(Icons.upload_outlined),
                title: l10n.settingsExportData,
                subtitle: l10n.settingsExportDataDesc,
                onTap: () => _handleExport(context, ref),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.download_outlined),
                title: l10n.settingsImportData,
                subtitle: l10n.settingsImportDataDesc,
                onTap: () => _handleImport(context, ref),
              ),
            ],
          ),

          const SizedBox(height: 24),

         
          // ─── 关于应用 ───
          _SectionHeader(title: l10n.settingsAboutSection),
          const SizedBox(height: 8),
          RippleSection(
            children: [
              RippleListTile(
                leading: const Icon(Icons.info_outlined),
                title: l10n.aboutAppTitle,
                showArrow: true,
                onTap: () => context.push(AppRouter.aboutApp),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleExpansionTile(
                leading: const Icon(Icons.mail_outline),
                title: l10n.settingsContactAuthor,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      children: [
                        _ContactItem(
                          icon: Icons.email_outlined,
                          label: l10n.settingsContactEmail,
                          value: l10n.settingsContactEmailAddress,
                          onTap: () => _copyToClipboard(
                            l10n.settingsContactEmailAddress,
                            l10n.toastCopiedEmail,
                            ref,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _ContactItem(
                          icon: Icons.chat_outlined,
                          label: l10n.settingsContactWeChat,
                          value: l10n.settingsContactWeChatId,
                          onTap: () => _launchWeChat(l10n.settingsContactWeChatId, context, ref),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.groups_outlined),
                title: l10n.settingsJoinGroup,
                showArrow: true,
                onTap: () => context.push(AppRouter.discussionGroup),
              ),
            ],
          ),

          const SizedBox(height: 16),
           // ─── DEBUG 模式：数据库重置 ───
          if (kDebugMode) ...[
            _SectionHeader(title: 'DEBUG'),
            const SizedBox(height: 8),
            RippleSection(
              children: [
                RippleExpansionTile(
                  leading: const Icon(Icons.delete_sweep_outlined),
                  title: l10n.debugResetDatabase,
                  subtitle: l10n.debugResetDatabaseDesc,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.debugResetDatabaseDesc,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.tonal(
                            onPressed: () => _handleDatabaseReset(context, ref),
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withValues(alpha: 0.15),
                              foregroundColor: Theme.of(context).colorScheme.error,
                            ),
                            child: Text(l10n.debugResetDatabase),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  /// 处理导出
  void _handleExport(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final toast = ref.read(toastProvider.notifier);

    try {
      await ref.read(dataTransferProvider.notifier).exportData();
      toast.showSuccess(l10n.toastExportSuccess);
    } catch (e) {
      toast.showError(l10n.toastExportFailed(e.toString()));
    }
  }

  /// 处理导入
  void _handleImport(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final toast = ref.read(toastProvider.notifier);

    // 先弹确认框
    final confirmed = await showAnimatedDialog<bool>(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: Text(
                        l10n.importConfirmTitle,
                        style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        l10n.importConfirmMessage,
                        style: Theme.of(ctx).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text(l10n.btnCancel),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: Text(l10n.btnConfirm),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (confirmed != true) return;

    try {
      final success = await ref
          .read(dataTransferProvider.notifier)
          .importData();
      if (success) {
        toast.showSuccess(l10n.toastImportSuccess);
      }
    } on FormatException {
      toast.showError(l10n.toastImportInvalidFile);
    } catch (e) {
      toast.showError(l10n.toastImportFailed(e.toString()));
    }
  }

  /// 处理数据库重置（DEBUG 模式）
  void _handleDatabaseReset(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final toast = ref.read(toastProvider.notifier);

    // 弹确认框
    final confirmed = await showAnimatedDialog<bool>(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                      child: Text(
                        l10n.debugResetConfirmTitle,
                        style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        l10n.debugResetConfirmMessage,
                        style: Theme.of(ctx).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text(l10n.btnCancel),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(ctx).colorScheme.error,
                            ),
                            child: Text(l10n.btnConfirm),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (confirmed != true) return;

    try {
      await ref.read(databaseResetProvider.notifier).resetAllDatabases();
      toast.showSuccess(l10n.debugResetSuccess);
    } catch (e) {
      toast.showError(l10n.debugResetFailed);
    }
  }

  String _themeLabel(ThemeModeSetting mode, AppLocalizations l10n) {
    switch (mode) {
      case ThemeModeSetting.system:
        return l10n.themeSystem;
      case ThemeModeSetting.light:
        return l10n.themeLight;
      case ThemeModeSetting.dark:
        return l10n.themeDark;
    }
  }

  /// 复制微信号到剪贴板并弹出Toast，同时尝试打开微信应用
  Future<void> _launchWeChat(String weChatId, BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    
    // 复制微信号到剪贴板
    await Clipboard.setData(ClipboardData(text: weChatId));
    // 弹出Toast提示
    ref.read(toastProvider.notifier).showSuccess(l10n.toastCopiedWeChat);
    
    try {
      // 尝试打开微信应用，使用 weixin:// 协议
      final weChatUrl = 'weixin://dl/chat/?$weChatId';
      if (await canLaunchUrl(Uri.parse(weChatUrl))) {
        await launchUrl(Uri.parse(weChatUrl));
      }
    } catch (e) {
      // 如果无法打开微信应用，忽略错误（微信号已复制）
    }
  }

  /// 复制到剪贴板
  void _copyToClipboard(String text, String message, WidgetRef ref) {
    Clipboard.setData(ClipboardData(text: text));
    ref.read(toastProvider.notifier).showSuccess(message);
  }
}

/// 联系项组件
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.copy_outlined,
              size: 18,
              color: theme.colorScheme.primary.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

/// 分区标题
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

/// 主题/语言选择卡片
class _ThemeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final primary = theme.colorScheme.primary;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? primary.withValues(alpha: 0.18)
                : isLight
                ? Colors.white.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? primary
                  : isLight
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: isSelected
                    ? primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
