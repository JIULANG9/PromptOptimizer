import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../domain/entities/optimization_state.dart';
import 'optimization_timer_display.dart';

/// 优化结果面板（桌面端右栏 / 移动端结果页内容）
class ResultPanel extends ConsumerStatefulWidget {
  final OptimizationState optimizationState;
  final ValueChanged<String>? onTextChanged;

  const ResultPanel({
    super.key,
    required this.optimizationState,
    this.onTextChanged,
  });

  @override
  ConsumerState<ResultPanel> createState() => _ResultPanelState();
}

class _ResultPanelState extends ConsumerState<ResultPanel> {
  late TextEditingController _textController;
  String? _lastOptimizedPrompt;
  bool _isUserEditing = false;
  Timer? _editingResetTimer;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: widget.optimizationState.optimizedPrompt,
    );
    _lastOptimizedPrompt = widget.optimizationState.optimizedPrompt;

    // 监听文本变化，标记用户正在编辑（仅在非流式状态下）
    _textController.addListener(() {
      if (widget.optimizationState.status != OptimizationStatus.streaming) {
        _isUserEditing = true;
        // 2秒后重置编辑状态
        _editingResetTimer?.cancel();
        _editingResetTimer = Timer(const Duration(seconds: 2), () {
          _isUserEditing = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(ResultPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 重置用户编辑状态当开始新的优化时
    if (oldWidget.optimizationState.status != OptimizationStatus.loading &&
        oldWidget.optimizationState.status != OptimizationStatus.streaming &&
        (widget.optimizationState.status == OptimizationStatus.loading ||
            widget.optimizationState.status == OptimizationStatus.streaming)) {
      _isUserEditing = false;
    }

    // 处理流式更新
    if (widget.optimizationState.status == OptimizationStatus.streaming &&
        widget.optimizationState.optimizedPrompt != _lastOptimizedPrompt) {
      // 流式更新时，将光标保持在文本末尾
      _textController.text = widget.optimizationState.optimizedPrompt;
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.optimizationState.optimizedPrompt.length),
      );
      _lastOptimizedPrompt = widget.optimizationState.optimizedPrompt;
    }
    // 仅在优化完成且用户不在编辑状态时更新控制器内容
    else if (widget.optimizationState.optimizedPrompt != _lastOptimizedPrompt &&
        widget.optimizationState.status == OptimizationStatus.success &&
        !_isUserEditing) {
      // 保存当前光标位置
      final selection = _textController.selection;
      _textController.text = widget.optimizationState.optimizedPrompt;
      // 恢复光标位置
      _textController.selection = selection;
      _lastOptimizedPrompt = widget.optimizationState.optimizedPrompt;
    }
  }

  @override
  void dispose() {
    _editingResetTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (!widget.optimizationState.hasResult &&
        widget.optimizationState.status != OptimizationStatus.streaming &&
        widget.optimizationState.status != OptimizationStatus.loading) {
      // 空状态
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_fix_high_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.optimizedResultHint,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    }

    return GlassCard(
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          // 标题栏 + 复制按钮
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
            child: Row(
              children: [
                Text(
                  l10n.labelOptimizedPrompt,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (widget.optimizationState.startTime != null)
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: OptimizationTimerDisplay(),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.5),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    onPressed:
                        widget.optimizationState.optimizedPrompt.isNotEmpty
                        ? () {
                            Clipboard.setData(
                              ClipboardData(
                                text: widget.optimizationState.optimizedPrompt,
                              ),
                            );
                            ref
                                .read(toastProvider.notifier)
                                .showSuccess(l10n.toastCopied);
                          }
                        : null,
                    tooltip: l10n.btnCopy,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),

          // 结果文本（可编辑）
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Focus(
                autofocus: false,
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: widget.onTextChanged,
                  decoration: const InputDecoration(
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

          // 错误信息
          if (widget.optimizationState.status == OptimizationStatus.error)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.optimizationState.errorMessage,
                style: TextStyle(color: theme.colorScheme.error, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }
}
