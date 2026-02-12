import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'toast_models.dart';
import 'toast_theme.dart';
import 'content_color.dart';
import 'dart:async';

class ToastContent extends StatefulWidget {
  final ToastRequest request;
  final ToastTheme style;
  final Color contentColor;
  final bool isExiting;

  const ToastContent({
    super.key,
    required this.request,
    required this.style,
    required this.contentColor,
    this.isExiting = false,
  });

  @override
  State<ToastContent> createState() => _ToastContentState();
}

class _ToastContentState extends State<ToastContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  Timer? _progressTimer;
  double _currentProgress = 0.0;
  bool _isPaused = false;
  bool _hasVibrated = false;

  @override
  void initState() {
    super.initState();
    _initProgressAnimation();
  }

  void _initProgressAnimation() {
    final isProgressType = widget.request.type == ToastType.progress;

    if (isProgressType) {
      // progress 类型:由外部传入的 progress 参数控制
      _progressController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      _currentProgress = widget.request.progress ?? 0.0;
      _progressController.value = _currentProgress;
    } else {
      // 其他类型:根据 duration 自动计算进度
      final duration = widget.request.duration ?? ToastTheme.defaultDuration;
      _progressController = AnimationController(
        vsync: this,
        duration: duration,
      );

      // 检查系统动画是否禁用
      final timeDilation = WidgetsBinding
          .instance
          .platformDispatcher
          .accessibilityFeatures
          .disableAnimations;
      if (!timeDilation) {
        _progressController.forward();
      }

      // 监听进度更新
      _progressController.addListener(() {
        if (mounted) {
          setState(() {
            _currentProgress = _progressController.value;
          });

          // 进度条完成后震动
          if (_currentProgress >= 1.0 && !_hasVibrated) {
            _hasVibrated = true;
            HapticFeedback.lightImpact();
          }
        }
      });
    }
  }

  @override
  void didUpdateWidget(ToastContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果是 progress 类型且进度值变化,更新进度
    if (widget.request.type == ToastType.progress) {
      final newProgress = widget.request.progress ?? 0.0;
      if (newProgress != _currentProgress) {
        setState(() {
          _currentProgress = newProgress;
        });
        _progressController.animateTo(
          newProgress,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );

        // 进度条完成后震动
        if (newProgress >= 1.0 && !_hasVibrated) {
          _hasVibrated = true;
          HapticFeedback.lightImpact();
        }
      }
    }
  }

  /// 暂停进度动画
  void _pauseProgress() {
    if (!_isPaused && _progressController.isAnimating) {
      _progressController.stop();
      setState(() {
        _isPaused = true;
      });
    }
  }

  /// 恢复进度动画
  void _resumeProgress() {
    if (_isPaused) {
      _progressController.forward();
      setState(() {
        _isPaused = false;
      });
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isProgressType = widget.request.type == ToastType.progress;
    final hasAction =
        widget.request.primaryAction != null ||
        widget.request.secondaryAction != null;
    final screenWidth = MediaQuery.of(context).size.width;

    // 宽度为屏幕的 95%
    final toastWidth = screenWidth * 0.95;

    // 使用圆角矩形
    final borderRadius = ToastTheme.rectRadius;

    return Center(
      child: SizedBox(
        width: toastWidth,
        child: GestureDetector(
          // 触摸暂停进度
          onTapDown: (_) => _pauseProgress(),
          onTapUp: (_) => _resumeProgress(),
          onTapCancel: () => _resumeProgress(),
          child: Material(
            elevation: 4,
            shadowColor: Colors.black26,
            color: widget.style.backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            clipBehavior: Clip.antiAlias,
            child: CustomPaint(
              painter: widget.isExiting
                  ? null
                  : _ProgressBackgroundPainter(
                      progress: _currentProgress,
                      color: widget.style.textColor ?? widget.contentColor,
                      borderRadius: borderRadius,
                    ),
              child: LocalContentColor(
                color: widget.style.textColor ?? widget.contentColor,
                child: Builder(
                  builder: (context) {
                    final contentColor = ToastTheme.contentColor(context);
                    return Container(
                      constraints: const BoxConstraints(minHeight: 48),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Icon
                              if (widget.request.icon != null)
                                widget.request.icon!
                              else if (isProgressType)
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: contentColor,
                                      value: _currentProgress,
                                    ),
                                  ),
                                )
                              else if (widget.style.icon != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Icon(
                                    widget.style.icon,
                                    color:
                                        widget.style.iconColor ?? contentColor,
                                    size: 20,
                                  ),
                                ),

                              // Message
                              Expanded(
                                child: Text(
                                  widget.request.message,
                                  style: TextStyle(
                                    color: contentColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                  maxLines: hasAction ? 3 : 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Progress Text (仅 progress 类型显示百分比)
                              if (isProgressType)
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    '${(_currentProgress * 100).toInt()}%',
                                    style: TextStyle(
                                      color: contentColor.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          // Action Buttons
                          if (hasAction)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (widget.request.secondaryAction != null)
                                    TextButton(
                                      onPressed: widget
                                          .request
                                          .secondaryAction!
                                          .onPressed,
                                      style: TextButton.styleFrom(
                                        foregroundColor: contentColor
                                            .withValues(alpha: 0.8),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 20,
                                        ),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        widget.request.secondaryAction!.label,
                                      ),
                                    ),
                                  if (widget.request.secondaryAction != null)
                                    const SizedBox(width: 12),
                                  if (widget.request.primaryAction != null)
                                    TextButton(
                                      onPressed: widget
                                          .request
                                          .primaryAction!
                                          .onPressed,
                                      style: TextButton.styleFrom(
                                        foregroundColor: contentColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 20,
                                        ),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      child: Text(
                                        widget.request.primaryAction!.label,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 背景进度条绘制器
/// 参考 Jetpack Compose 的 drawBehind 实现
class _ProgressBackgroundPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double borderRadius;

  _ProgressBackgroundPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    // 计算进度条宽度
    final progressWidth = size.width * progress;

    // 绘制半透明圆角进度条
    final paint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final rect = RRect.fromLTRBR(
      0,
      0,
      progressWidth,
      size.height,
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(_ProgressBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}
