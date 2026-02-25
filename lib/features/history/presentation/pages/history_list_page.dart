import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../providers/history_provider.dart';
import '../widgets/history_item.dart';

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
                    child: HistoryItem(
                      title: history.promptSummary,
                      time: history.formattedTime,
                      type: isUser ? 'User' : 'System',
                      isUserType: isUser,
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
