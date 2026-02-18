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
              RippleExpansionTile(
                leading: const Icon(Icons.language_outlined),
                title: l10n.settingsWebsite,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      children: [
                        _LinkItem(
                          icon: Icons.public_outlined,
                          label: 'Official Website',
                          value: 'app.jiulang9.com',
                          onTap: () => _launchUrl('https://app.jiulang9.com'),
                        ),
                        const SizedBox(height: 12),
                        _LinkItem(
                          icon: Icons.code_outlined,
                          label: 'GitHub',
                          value: 'github.com/JIULANG9/PromptOptimizer',
                          onTap: () => _launchUrl('https://github.com/JIULANG9/PromptOptimizer'),
                        ),
                      ],
                    ),
                  ),
                ],
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
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: l10n.settingsPrivacyPolicy,
                showArrow: true,
                onTap: () => context.push(AppRouter.privacyPolicy),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.description_outlined),
                title: l10n.settingsUserAgreement,
                showArrow: true,
                onTap: () => context.push(AppRouter.userAgreement),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.code_outlined),
                title: l10n.settingsOpenSource,
                showArrow: true,
                onTap: () => context.push(AppRouter.openSource),
              ),
            ],
          ),

          const SizedBox(height: 16),
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
      builder: (ctx) => AlertDialog(
        title: Text(l10n.importConfirmTitle),
        content: Text(l10n.importConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.btnCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.btnConfirm),
          ),
        ],
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

  /// 打开 URL 链接
  Future<void> _launchUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // 如果无法打开链接，忽略错误
    }
  }

  /// 打开微信应用或复制微信号
  Future<void> _launchWeChat(String weChatId, BuildContext context, WidgetRef ref) async {
    // 在异步调用前获取 l10n
    final l10n = AppLocalizations.of(context)!;
    
    try {
      // 尝试打开微信应用，使用 weixin:// 协议
      final weChatUrl = 'weixin://dl/chat/?$weChatId';
      if (await canLaunchUrl(Uri.parse(weChatUrl))) {
        await launchUrl(Uri.parse(weChatUrl));
      } else {
        // 如果微信应用未安装，复制微信号到剪贴板
        Clipboard.setData(ClipboardData(text: weChatId));
        ref.read(toastProvider.notifier).showSuccess(l10n.toastCopiedWeChat);
      }
    } catch (e) {
      // 如果无法打开微信，复制微信号到剪贴板
      Clipboard.setData(ClipboardData(text: weChatId));
      ref.read(toastProvider.notifier).showSuccess(l10n.toastCopiedWeChat);
    }
  }

  /// 复制到剪贴板
  void _copyToClipboard(String text, String message, WidgetRef ref) {
    Clipboard.setData(ClipboardData(text: text));
    ref.read(toastProvider.notifier).showSuccess(message);
  }
}

/// 链接项组件（用于官网和 GitHub）
class _LinkItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _LinkItem({
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
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new_outlined,
              size: 18,
              color: theme.colorScheme.primary.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
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
