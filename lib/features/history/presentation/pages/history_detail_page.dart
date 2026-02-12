import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../domain/entities/history_entity.dart';
import '../providers/history_provider.dart';

/// 历史记录详情页面
class HistoryDetailPage extends ConsumerStatefulWidget {
  final String historyId;

  const HistoryDetailPage({super.key, required this.historyId});

  @override
  ConsumerState<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends ConsumerState<HistoryDetailPage> {
  HistoryEntity? _history;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final useCases = ref.read(historyUseCasesProvider);
    final history = await useCases.getById(widget.historyId);
    if (mounted) {
      setState(() {
        _history = history;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (_isLoading) {
      return GlassScaffold(
        appBar: AppBar(title: Text(l10n.historyDetail)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_history == null) {
      return GlassScaffold(
        appBar: AppBar(title: Text(l10n.historyDetail)),
        body: const Center(child: Icon(Icons.error_outline, size: 48)),
      );
    }

    final history = _history!;

    return GlassScaffold(
      appBar: AppBar(
        title: Text(l10n.historyDetail),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: history.optimizedPrompt));
              ref.read(toastProvider.notifier).showSuccess(l10n.toastCopied);
            },
            tooltip: l10n.btnCopy,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              ref.read(historyListProvider.notifier).deleteHistory(history.id);
              Navigator.pop(context);
            },
            tooltip: l10n.btnDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 元信息
            Row(
              children: [
                Text(
                  history.formattedTime,
                  style: TextStyle(
                    fontSize: 13,
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
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    history.type,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 原始提示词
            Text(
              l10n.labelOriginalPrompt,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            GlassCard(
              padding: const EdgeInsets.all(14),
              borderRadius: BorderRadius.circular(12),
              blurSigma: 15,
              child: SelectableText(
                history.originalPrompt,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 优化后提示词
            Text(
              l10n.labelOptimizedPrompt,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            GlassCard(
              padding: const EdgeInsets.all(14),
              borderRadius: BorderRadius.circular(12),
              blurSigma: 15,
              lightOpacity: 0.5,
              darkOpacity: 0.35,
              child: SelectableText(
                history.optimizedPrompt,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
