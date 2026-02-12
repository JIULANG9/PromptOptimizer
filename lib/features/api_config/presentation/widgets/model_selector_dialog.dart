import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/dialogs/animated_dialog.dart';
import '../../data/model_provider_service.dart';

/// 模型提供商选择对话框
/// 返回用户选择的 ModelProvider，取消返回 null
Future<ModelProvider?> showProviderSelectorDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  return showAnimatedDialog<ModelProvider>(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  l10n.labelSelectProvider,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 提供商列表
              ...ModelProvider.values.map(
                (provider) => _ProviderTile(
                  provider: provider,
                  onTap: () => Navigator.of(ctx).pop(provider),
                ),
              ),
              const SizedBox(height: 8),
              // 取消按钮
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(l10n.btnCancel),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// 单个提供商选项
class _ProviderTile extends StatelessWidget {
  final ModelProvider provider;
  final VoidCallback onTap;

  const _ProviderTile({required this.provider, required this.onTap});

  IconData get _icon {
    switch (provider) {
      case ModelProvider.dashScope:
        return Icons.cloud_outlined;
      case ModelProvider.modelScope:
        return Icons.hub_outlined;
      case ModelProvider.openAI:
        return Icons.auto_awesome_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(_icon, size: 22, color: theme.colorScheme.primary),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    provider.displayName,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: theme.colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 模型列表选择对话框
/// 传入已加载的模型列表，返回用户选择的模型 ID
Future<String?> showModelListDialog({
  required BuildContext context,
  required List<ModelInfo> models,
  required ModelProvider provider,
}) {
  final l10n = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  return showAnimatedDialog<String>(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 标题栏
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.labelSelectModel,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${provider.displayName} · ${l10n.labelModelCount(models.length)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: IconButton.styleFrom(
                      foregroundColor: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // 模型列表
            if (models.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  l10n.labelNoModels,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: models.length,
                  itemBuilder: (context, index) {
                    final model = models[index];
                    return _ModelTile(
                      model: model,
                      onTap: () => Navigator.of(ctx).pop(model.id),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

/// 单个模型选项
class _ModelTile extends StatelessWidget {
  final ModelInfo model;
  final VoidCallback onTap;

  const _ModelTile({required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.smart_toy_outlined,
                  size: 18,
                  color: theme.colorScheme.primary.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.id,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (model.ownedBy.isNotEmpty)
                        Text(
                          model.ownedBy,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
