import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../../template/presentation/providers/template_provider.dart';
import '../../../widgets/dialogs/animated_dialog.dart';
import '../../../widgets/glass/glass_widgets.dart';
import 'glass_selection_item.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../../widgets/toast/toast_models.dart';
import '../providers/optimization_provider.dart';

/// 控制面板 — 模型选择 + 模板选择
class ControlPanel extends ConsumerWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final optState = ref.watch(optimizationProvider);
    final apiConfigs = ref.watch(apiConfigListProvider);
    final templates = ref.watch(templateListProvider);

    // 当前选中的配置名称
    final selectedConfigName =
        apiConfigs.configs
            .where((c) => c.id == optState.selectedApiConfigId)
            .map((c) => c.name)
            .firstOrNull ??
        l10n.labelModelSelect;

    // 当前选中的模板名称
    final selectedTemplateName =
        templates.templates
            .where((t) => t.id == optState.selectedTemplateId)
            .map((t) => t.name)
            .firstOrNull ??
        l10n.labelTemplateSelect;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          // 模型选择按钮
          Expanded(
            child: _SelectorButton(
              icon: Icons.smart_toy_outlined,
              label: selectedConfigName,
              onTap: () => _showModelSelector(context, ref),
            ),
          ),
          const SizedBox(width: 8),
          // 模板选择按钮
          Expanded(
            child: _SelectorButton(
              icon: Icons.description_outlined,
              label: selectedTemplateName,
              onTap: () => _showTemplateSelector(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  void _showModelSelector(BuildContext context, WidgetRef ref) {
    final configs = ref
        .read(apiConfigListProvider)
        .configs
        .where((c) => c.isEnabled)
        .toList();
    final currentId = ref.read(optimizationProvider).selectedApiConfigId;
    final l10n = AppLocalizations.of(context)!;

    // 无可用配置时显示 Action Toast
    if (configs.isEmpty) {
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
      return;
    }

    showAnimatedDialog(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 480),
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
                  color: Theme.of(context).brightness == Brightness.light
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Text(
                          l10n.labelModelSelect,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                          itemCount: configs.length,
                          itemBuilder: (_, index) {
                            final config = configs[index];
                            final isSelected = config.id == currentId;
                            return GlassSelectionItem(
                              title: config.name,
                              subtitle: config.modelId,
                              isSelected: isSelected,
                              onTap: () {
                                ref.read(optimizationProvider.notifier)
                                    .selectApiConfig(config.id);
                                Navigator.pop(ctx);
                              },
                            );
                          },
                        ),
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

  void _showTemplateSelector(BuildContext context, WidgetRef ref) {
    final currentTab = ref.read(optimizationProvider).currentTab;
    final allTemplates = ref.read(templateListProvider).templates;
    final filtered = allTemplates
        .where((t) => t.templateType == currentTab)
        .toList();
    final currentId = ref.read(optimizationProvider).selectedTemplateId;
    final l10n = AppLocalizations.of(context)!;

    showAnimatedDialog(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 480),
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
                  color: Theme.of(context).brightness == Brightness.light
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Text(
                          l10n.labelTemplateSelect,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                          itemCount: filtered.length,
                          itemBuilder: (_, index) {
                            final template = filtered[index];
                            final isSelected = template.id == currentId;
                            return GlassSelectionItem(
                              title: template.name,
                              subtitle: template.description.isNotEmpty
                                  ? template.description
                                  : null,
                              isSelected: isSelected,
                              onTap: () {
                                ref
                                    .read(optimizationProvider.notifier)
                                    .selectTemplate(template.id);
                                Navigator.pop(ctx);
                              },
                            );
                          },
                        ),
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
}

/// 选择器按钮组件
class _SelectorButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SelectorButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        borderRadius: BorderRadius.circular(10),
        blurSigma: 15,
        child: Row(
          children: [
            Icon(icon, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.expand_more,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
