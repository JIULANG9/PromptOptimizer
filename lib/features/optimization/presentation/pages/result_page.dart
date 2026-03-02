import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({super.key});

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  double _launcherHeight = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final optState = ref.watch(optimizationProvider);
    final isMobilePlatform = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);

    Widget buildMovableResultPanel() {
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      final effectiveBottomInset = math.max(0.0, bottomInset - _launcherHeight);
      return AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: effectiveBottomInset),
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
                _SizeReportingWidget(
                  onHeightChange: (height) {
                    if (!mounted || height == _launcherHeight) return;
                    setState(() {
                      _launcherHeight = height;
                    });
                  },
                  child: AIAppLauncherSection(
                    promptText: optState.optimizedPrompt,
                  ),
                ),
              ],
            )
          : buildMovableResultPanel(),
    );
  }
}

class _SizeReportingWidget extends SingleChildRenderObjectWidget {
  final ValueChanged<double> onHeightChange;

  const _SizeReportingWidget({
    required this.onHeightChange,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SizeReportingRenderObject(onHeightChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderObject renderObject,
  ) {
    (renderObject as _SizeReportingRenderObject).onHeightChange =
        onHeightChange;
  }
}

class _SizeReportingRenderObject extends RenderProxyBox {
  ValueChanged<double> onHeightChange;
  double _lastHeight = -1;

  _SizeReportingRenderObject(this.onHeightChange);

  @override
  void performLayout() {
    super.performLayout();
    final newHeight = size.height;
    if (newHeight == _lastHeight) return;
    _lastHeight = newHeight;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onHeightChange(newHeight);
    });
  }
}
