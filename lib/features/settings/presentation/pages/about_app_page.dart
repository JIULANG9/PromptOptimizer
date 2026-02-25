import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/item/ripple_list_tile.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../providers/version_provider.dart';

/// 关于应用页面
class AboutAppPage extends ConsumerWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GlassScaffold(
      appBar: AppBar(title: Text(l10n.aboutAppTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ─── 顶部信息区 ───
          Center(
            child: Column(
              children: [
                // App Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // App Name
                Text(
                  l10n.appTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),

                // Slogan
                Text(
                  l10n.aboutAppSlogan,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Version (Clickable to copy)
                ref.watch(versionProvider).when(
                  data: (version) => GestureDetector(
                    onTap: () => _copyVersion(context, ref, version),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.aboutAppVersion(version),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.copy_outlined,
                            size: 16,
                            color: theme.colorScheme.primary.withValues(alpha: 0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  loading: () => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'v...',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  error: (error, stackTrace) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      l10n.aboutAppVersion('unknown'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // ─── 底部链接区 ───
          _SectionHeader(title: l10n.aboutAppOfficialWebsite),
          const SizedBox(height: 8),
          RippleSection(
            children: [
              RippleExpansionTile(
                leading: const Icon(Icons.language_outlined),
                title: l10n.aboutAppOfficialWebsite,
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
            ],
          ),

          const SizedBox(height: 16),

          // ─── 政策链接 ───
          RippleSection(
            children: [
              RippleListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: l10n.aboutAppPrivacyPolicy,
                showArrow: true,
                onTap: () => context.push(AppRouter.privacyPolicy),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.description_outlined),
                title: l10n.aboutAppUserAgreement,
                showArrow: true,
                onTap: () => context.push(AppRouter.userAgreement),
              ),
              const Divider(height: 1, indent: 16, endIndent: 16),
              RippleListTile(
                leading: const Icon(Icons.code_outlined),
                title: l10n.aboutAppOpenSource,
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

  /// 复制版本号到剪贴板
  void _copyVersion(BuildContext context, WidgetRef ref, String version) {
    final l10n = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: version));
    ref.read(toastProvider.notifier).showSuccess(l10n.toastCopiedVersion);
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
