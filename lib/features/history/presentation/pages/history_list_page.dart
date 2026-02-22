import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../providers/history_provider.dart';

/// 历史记录列表页面
class HistoryListPage extends ConsumerStatefulWidget {
  const HistoryListPage({super.key});

  @override
  ConsumerState<HistoryListPage> createState() => _HistoryListPageState();
}

class _HistoryListPageState extends ConsumerState<HistoryListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyListProvider.notifier).loadHistories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyListProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        actions: [
          if (state.histories.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () => _showClearConfirm(context, l10n),
              tooltip: l10n.historyClearAll,
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.histories.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.historyEmpty,
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
              itemCount: state.histories.length,
              itemBuilder: (context, index) {
                final history = state.histories[index];
                final isUser = history.type == AppConstants.templateTypeUser;
                return Dismissible(
                  key: Key(history.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: theme.colorScheme.error,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref
                        .read(historyListProvider.notifier)
                        .deleteHistory(history.id);
                  },
                  child: GlassCard(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    borderRadius: BorderRadius.circular(12),
                    blurSigma: 15,
                    child: ListTile(
                      title: Text(
                        history.promptSummary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            Text(
                              history.formattedTime,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    (isUser
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.secondary)
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
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right, size: 20),
                      onTap: () =>
                          context.push(AppRouter.historyDetailPath(history.id)),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showClearConfirm(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmClearTitle),
        content: Text(l10n.historyClearConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.btnCancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(historyListProvider.notifier).clearAll();
              Navigator.pop(ctx);
            },
            child: Text(
              l10n.btnClearAll,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
