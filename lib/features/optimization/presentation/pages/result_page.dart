import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../providers/optimization_provider.dart';
import '../widgets/result_panel.dart';

/// 移动端优化结果页面
class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final optState = ref.watch(optimizationProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(l10n.labelOptimizedPrompt),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: optState.optimizedPrompt.isNotEmpty
                ? () {
                    Clipboard.setData(
                      ClipboardData(text: optState.optimizedPrompt),
                    );
                    ref
                        .read(toastProvider.notifier)
                        .showSuccess(l10n.toastCopied);
                  }
                : null,
            tooltip: l10n.btnCopy,
          ),
        ],
      ),
      body: ResultPanel(
        optimizationState: optState,
        onTextChanged: (text) =>
            ref.read(optimizationProvider.notifier).updateOptimizedPrompt(text),
      ),
    );
  }
}
