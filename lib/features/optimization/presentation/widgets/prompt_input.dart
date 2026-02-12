import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import 'optimization_timer_display.dart';

/// 原始提示词输入区域
class PromptInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isProcessing;
  final VoidCallback onOptimize;
  final VoidCallback? onPaste;

  const PromptInput({
    super.key,
    required this.controller,
    required this.isProcessing,
    required this.onOptimize,
    this.onPaste,
  });

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GlassCard(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          // 优化按钮
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: widget.isProcessing ? null : widget.onOptimize,
                icon: widget.isProcessing
                    ? OptimizationTimerDisplay(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 14,
                      )
                    : const Icon(Icons.auto_fix_high),
                label: Text(
                  widget.isProcessing ? l10n.toastOptimizing : l10n.btnOptimize,
                ),
              ),
            ),
          ),
          // 标题栏
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
            child: Row(
              children: [
                Text(
                  l10n.labelOriginalPrompt,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                // 粘贴按钮
                IconButton(
                  icon: Icon(
                    Icons.paste,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () async {
                    final data = await Clipboard.getData('text/plain');
                    if (data?.text != null) {
                      widget.controller.text = data!.text!;
                    }
                  },
                  tooltip: l10n.btnPaste,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // 输入框
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Focus(
                autofocus: false,
                child: TextField(
                  controller: widget.controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: l10n.promptInputHint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
