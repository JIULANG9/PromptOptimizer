import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../settings/domain/entities/version_info.dart';
import '../../settings/presentation/providers/version_check_provider.dart';

class UpdateDialog extends ConsumerWidget {
  final VersionInfo versionInfo;

  const UpdateDialog({
    super.key,
    required this.versionInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        constraints: const BoxConstraints(maxWidth: 400),
        width: MediaQuery.of(context).size.width - 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? Colors.white.withValues(alpha: 0.8)
                    : Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.updateDialogTitle(versionInfo.versionName),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        versionInfo.updateMsg,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => _handleIgnore(context, ref),
                            child: Text(l10n.btnIgnoreThreeDays),
                          ),
                          const SizedBox(width: 12),
                          FilledButton(
                            onPressed: () => _handleUpdate(context),
                            child: Text(l10n.btnUpdate),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleIgnore(BuildContext context, WidgetRef ref) {
    ref.read(versionCheckProvider.notifier).ignoreUpdate();
    Navigator.pop(context);
  }

  void _handleUpdate(BuildContext context) async {
    Navigator.pop(context);
    try {
      final uri = Uri.parse(versionInfo.downloadUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // 打开链接失败，静默处理
    }
  }
}
