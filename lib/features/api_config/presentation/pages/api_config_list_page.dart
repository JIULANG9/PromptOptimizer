import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../optimization/presentation/providers/optimization_provider.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../../widgets/toast/toast_models.dart';
import '../../domain/entities/api_config_entity.dart';
import '../providers/api_config_provider.dart';

/// API 配置列表页面
class ApiConfigListPage extends ConsumerWidget {
  const ApiConfigListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(apiConfigListProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GlassScaffold(
      appBar: AppBar(title: Text(l10n.apiConfigTitle)),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.configs.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_off_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.apiConfigEmpty,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              itemCount: state.configs.length,
              itemBuilder: (context, index) {
                final config = state.configs[index];
                return _ApiConfigCard(
                  config: config,
                  onTap: () =>
                      context.push(AppRouter.apiConfigEditPath(config.id)),
                  onToggle: () {
                    ref
                        .read(apiConfigListProvider.notifier)
                        .toggleEnabled(config.id);
                    // 禁用后自动切换选中状态
                    _autoSwitchAfterChange(context, ref);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRouter.apiConfigNew),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 删除或禁用后，自动切换首页选中的 API 配置
  /// - 若仍有启用的配置 → 选中第一个启用的
  /// - 若无启用的配置 → 清空选中并弹出 Action Toast
  void _autoSwitchAfterChange(BuildContext context, WidgetRef ref) {
    // 延迟一帧等待 apiConfigListProvider 状态刷新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final configs = ref.read(apiConfigListProvider).configs;
      final enabledConfigs = configs.where((c) => c.isEnabled).toList();
      final optNotifier = ref.read(optimizationProvider.notifier);
      final currentSelectedId = ref
          .read(optimizationProvider)
          .selectedApiConfigId;

      if (enabledConfigs.isNotEmpty) {
        // 当前选中的配置是否仍然有效（存在且启用）
        final stillValid = enabledConfigs.any((c) => c.id == currentSelectedId);
        if (!stillValid) {
          // 自动切换到第一个启用的配置
          optNotifier.selectApiConfig(enabledConfigs.first.id);
        }
      } else {
        // 无可用配置 → 清空选中，弹出 Action Toast
        optNotifier.selectApiConfig('');
        final l10n = AppLocalizations.of(context)!;
        ref
            .read(toastProvider.notifier)
            .showAction(
              message: l10n.apiConfigNoAvailable,
              type: ToastType.normal,
              primaryAction: ToastAction(
                label: l10n.btnAddNow,
                onPressed: () {
                  context.push(AppRouter.apiConfigNew);
                },
              ),
              duration: const Duration(seconds: 4),
            );
      }
    });
  }
}

/// 单个 API 配置卡片
class _ApiConfigCard extends StatelessWidget {
  final ApiConfigEntity config;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const _ApiConfigCard({
    required this.config,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        borderRadius: BorderRadius.circular(12),
        blurSigma: 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题行
            Row(
              children: [
                Expanded(
                  child: Text(
                    config.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                _buildBadge(
                  config.isEnabled ? l10n.labelEnabled : l10n.labelDisabled,
                  config.isEnabled
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Base URL
            Text(
              config.truncatedBaseUrl,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            // Model ID
            Text(
              config.modelId,
              style: TextStyle(fontSize: 12, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 8),
            // 底部操作栏
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 启用/禁用
                TextButton.icon(
                  onPressed: onToggle,
                  icon: Icon(
                    config.isEnabled
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    size: 18,
                  ),
                  label: Text(l10n.apiConfigToggleEnabled),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.onSurfaceVariant,
                    textStyle: const TextStyle(fontSize: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
