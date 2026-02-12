import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../providers/about_section_provider.dart';

/// 交流群页面
/// 展示微信交流群二维码和引导文案，支持保存二维码到相册
class DiscussionGroupPage extends ConsumerWidget {
  const DiscussionGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final saveStatus = ref.watch(aboutSectionProvider);
    final theme = Theme.of(context);

    return GlassScaffold(
      appBar: AppBar(title: Text(l10n.settingsJoinGroup)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 引导文案
              Text(
                l10n.groupGuideText,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // 二维码卡片（圆角卡片包裹）
              GlassCard(
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/wechat_discussion_group.jpg',
                    width: 240,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 保存按钮
              FilledButton.icon(
                onPressed: saveStatus == QrCodeSaveStatus.saving
                    ? null
                    : () => _handleSaveQrCode(context, ref),
                icon: saveStatus == QrCodeSaveStatus.saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_alt_outlined),
                label: Text(l10n.btnSaveQrCode),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 处理保存二维码
  void _handleSaveQrCode(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final toast = ref.read(toastProvider.notifier);

    await ref.read(aboutSectionProvider.notifier).saveQrCode();

    final status = ref.read(aboutSectionProvider);
    if (status == QrCodeSaveStatus.success) {
      toast.showSuccess(l10n.toastQrCodeSaved);
    } else {
      toast.showError(l10n.toastSaveQrCodeFailed);
    }

    ref.read(aboutSectionProvider.notifier).resetState();
  }
}
