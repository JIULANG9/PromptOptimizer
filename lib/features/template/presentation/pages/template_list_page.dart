import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../providers/template_provider.dart';

/// 模板列表页面
class TemplateListPage extends ConsumerWidget {
  const TemplateListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(templateListProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GlassScaffold(
      appBar: AppBar(title: Text(l10n.templateTitle)),
      body: Column(
        children: [
          // 类型筛选 Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.labelAll,
                  selected: state.filterType == 'all',
                  onSelected: () => ref
                      .read(templateListProvider.notifier)
                      .filterByType('all'),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.labelUserOptimize,
                  selected: state.filterType == AppConstants.templateTypeUser,
                  onSelected: () => ref
                      .read(templateListProvider.notifier)
                      .filterByType(AppConstants.templateTypeUser),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.labelSystemOptimize,
                  selected: state.filterType == AppConstants.templateTypeSystem,
                  onSelected: () => ref
                      .read(templateListProvider.notifier)
                      .filterByType(AppConstants.templateTypeSystem),
                ),
              ],
            ),
          ),

          // 模板列表
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.templates.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.templateEmpty,
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    itemCount: state.templates.length,
                    itemBuilder: (context, index) {
                      final template = state.templates[index];
                      return GlassCard(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        borderRadius: BorderRadius.circular(12),
                        blurSigma: 15,
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  template.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _buildTypeBadge(template.templateType, theme),
                              if (template.isBuiltin) ...[
                                const SizedBox(width: 6),
                                _buildBadge(
                                  l10n.labelBuiltin,
                                  theme.colorScheme.secondary,
                                ),
                              ],
                            ],
                          ),
                          subtitle: template.description.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    template.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                )
                              : null,
                          onTap: () {
                            context.push(
                              AppRouter.templateEditPath(template.id),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRouter.templateNew),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTypeBadge(String type, ThemeData theme) {
    final isUser = type == AppConstants.templateTypeUser;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color:
            (isUser ? theme.colorScheme.primary : theme.colorScheme.secondary)
                .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isUser ? 'User' : 'System',
        style: TextStyle(
          fontSize: 10,
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.secondary,
          fontWeight: FontWeight.w600,
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

/// 筛选 Chip 组件
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onSelected,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        borderRadius: BorderRadius.circular(8),
        blurSigma: 12,
        lightOpacity: selected ? 0.3 : 0.5,
        darkOpacity: selected ? 0.2 : 0.35,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
