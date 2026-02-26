import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../domain/entities/optimization_state.dart';
import '../providers/optimization_provider.dart';
import '../widgets/ai_app_launcher_section.dart';
import '../widgets/result_panel.dart';

/// 移动端优化结果页面
class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final optState = ref.watch(optimizationProvider);
    final isMobilePlatform = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);

    Widget buildMovableResultPanel() {
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      return AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: ResultPanel(
          optimizationState: optState,
          onTextChanged: (text) => ref
              .read(optimizationProvider.notifier)
              .updateOptimizedPrompt(text),
        ),
      );
    }

    return GlassScaffold(
      resizeToAvoidBottomInset: false,
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
      body: (isMobilePlatform || kIsWeb) &&
              optState.status == OptimizationStatus.success
          ? Column(
              children: [
                Expanded(
                  child: buildMovableResultPanel(),
                ),
                AIAppLauncherSection(
                  promptText: optState.optimizedPrompt,
                ),
              ],
            )
          : buildMovableResultPanel(),
    );
  }
}
