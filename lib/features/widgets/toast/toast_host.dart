import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'toast_controller.dart';
import 'toast_models.dart';
import 'toast_theme.dart';
import 'toast_widgets.dart';

/// Toast 宿主容器
///
/// 参考 Jetpack Compose Toast 动画逻辑：
/// - 顶部 Toast：下滑进入，上滑 + 渐隐退出
/// - 底部 Toast：上滑进入，下滑 + 渐隐退出
/// - 支持手势拖拽关闭
class ToastHost extends ConsumerWidget {
  final Widget child;

  const ToastHost({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(toastProvider);
    final current = state.current;

    return Stack(
      alignment: Alignment.center,
      children: [
        // App Content
        child,

        // Toast Overlay with AnimatedSwitcher for exit animation
        _ToastOverlay(
          request: current,
          onDismiss: (id) => ref.read(toastProvider.notifier).dismiss(id),
        ),
      ],
    );
  }
}

/// Toast 覆盖层，管理进出场动画
class _ToastOverlay extends StatefulWidget {
  final ToastRequest? request;
  final void Function(String?) onDismiss;

  const _ToastOverlay({required this.request, required this.onDismiss});

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> {
  ToastRequest? _currentRequest;
  ToastRequest? _exitingRequest;

  @override
  void initState() {
    super.initState();
    _currentRequest = widget.request;
  }

  @override
  void didUpdateWidget(covariant _ToastOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldId = oldWidget.request?.id ?? oldWidget.request?.message;
    final newId = widget.request?.id ?? widget.request?.message;

    if (oldId != newId) {
      // Toast 切换或消失
      if (oldWidget.request != null && widget.request == null) {
        // 从有到无：触发退出动画
        setState(() {
          _exitingRequest = oldWidget.request;
          _currentRequest = null;
        });
      } else if (oldWidget.request != null && widget.request != null) {
        // 从一个切换到另一个：先退出旧的，再进入新的
        setState(() {
          _exitingRequest = oldWidget.request;
          _currentRequest = widget.request;
        });
      } else {
        // 从无到有：直接进入
        setState(() {
          _currentRequest = widget.request;
          _exitingRequest = null;
        });
      }
    } else if (widget.request != null) {
      // 同一个 Toast 的内容更新（如进度更新）
      setState(() {
        _currentRequest = widget.request;
      });
    }
  }

  void _onExitComplete() {
    if (mounted) {
      setState(() {
        _exitingRequest = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 退出中的 Toast
        if (_exitingRequest != null)
          _ToastAnimatedContainer(
            key: ValueKey(
              'exit_${_exitingRequest!.id ?? _exitingRequest!.message}',
            ),
            request: _exitingRequest!,
            isEntering: false,
            onDismiss: widget.onDismiss,
            onAnimationComplete: _onExitComplete,
          ),
        // 当前显示的 Toast
        if (_currentRequest != null)
          _ToastAnimatedContainer(
            key: ValueKey(
              'enter_${_currentRequest!.id ?? _currentRequest!.message}',
            ),
            request: _currentRequest!,
            isEntering: true,
            onDismiss: widget.onDismiss,
            onAnimationComplete: null,
          ),
      ],
    );
  }
}

/// 带动画的 Toast 容器
///
/// 支持：
/// - 进入动画：滑入 + 渐显
/// - 退出动画：反向滑出 + 渐隐
/// - 手势拖拽关闭（参考 Kotlin 的 toastGesturesDetector）
class _ToastAnimatedContainer extends StatefulWidget {
  final ToastRequest request;
  final bool isEntering;
  final void Function(String?) onDismiss;
  final VoidCallback? onAnimationComplete;

  const _ToastAnimatedContainer({
    super.key,
    required this.request,
    required this.isEntering,
    required this.onDismiss,
    this.onAnimationComplete,
  });

  @override
  State<_ToastAnimatedContainer> createState() =>
      _ToastAnimatedContainerState();
}

class _ToastAnimatedContainerState extends State<_ToastAnimatedContainer>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // 手势拖拽相关
  double _dragOffset = 0.0;
  bool _isDragging = false;
  bool _isDismissedByGesture = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();

    if (widget.isEntering) {
      // 进入动画
      _slideController.forward();
      _fadeController.forward();
    } else {
      // 退出动画：从完全显示状态开始反向播放
      _slideController.value = 1.0;
      _fadeController.value = 1.0;
      _playExitAnimation();
    }
  }

  void _initAnimations() {
    final isTop = widget.request.position == ToastPosition.top;

    // 滑动动画控制器
    _slideController = AnimationController(
      duration: ToastTheme.animationDuration,
      vsync: this,
    );

    // 渐变动画控制器
    _fadeController = AnimationController(
      duration: ToastTheme.animationDuration,
      vsync: this,
    );

    // 三阶贝塞尔曲线 - 略带回弹效果
    const enterCurve = Cubic(0.175, 0.885, 0.32, 1.275);
    // 退出曲线 - 平滑减速
    const exitCurve = Curves.easeOut;

    // 顶部从上方滑入，底部从下方滑入
    final beginOffset = isTop ? const Offset(0, -1.0) : const Offset(0, 1.0);

    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _slideController,
            curve: widget.isEntering ? enterCurve : exitCurve,
          ),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
  }

  Future<void> _playExitAnimation() async {
    // 退出动画：反向滑动 + 渐隐
    await Future.wait([_slideController.reverse(), _fadeController.reverse()]);
    widget.onAnimationComplete?.call();
  }

  /// 手势拖拽开始
  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  /// 手势拖拽更新
  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final isTop = widget.request.position == ToastPosition.top;
    final delta = details.delta.dy;

    // 顶部 Toast 只允许向上拖（负值），底部 Toast 只允许向下拖（正值）
    if (isTop) {
      // 顶部：向上拖动（负值）有效，向下拖动受限
      _dragOffset = (_dragOffset + delta).clamp(-200.0, 20.0);
    } else {
      // 底部：向下拖动（正值）有效，向上拖动受限
      _dragOffset = (_dragOffset + delta).clamp(-20.0, 200.0);
    }

    setState(() {});
  }

  /// 手势拖拽结束
  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;

    final isTop = widget.request.position == ToastPosition.top;
    final velocity = details.velocity.pixelsPerSecond.dy;

    // 判断是否应该关闭
    // 顶部 Toast：向上拖动超过阈值或速度足够快
    // 底部 Toast：向下拖动超过阈值或速度足够快
    final shouldDismiss = isTop
        ? (_dragOffset < -50 || velocity < -500)
        : (_dragOffset > 50 || velocity > 500);

    if (shouldDismiss) {
      _dismissWithAnimation(velocity);
    } else {
      _snapBack();
    }

    setState(() {
      _isDragging = false;
    });
  }

  /// 带动画关闭
  Future<void> _dismissWithAnimation(double velocity) async {
    if (_isDismissedByGesture) return;
    _isDismissedByGesture = true;

    final isTop = widget.request.position == ToastPosition.top;
    final targetOffset = isTop ? -300.0 : 300.0;

    // 使用动画控制器滑出
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    final animation = Tween<double>(
      begin: _dragOffset,
      end: targetOffset,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dragOffset = animation.value;
        });
      }
    });

    // 同时渐隐
    _fadeController.reverse();

    await controller.forward();
    controller.dispose();

    // 通知关闭
    widget.onDismiss(widget.request.id);
  }

  /// 回弹到原位
  void _snapBack() {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    final animation = Tween<double>(
      begin: _dragOffset,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    animation.addListener(() {
      if (mounted) {
        setState(() {
          _dragOffset = animation.value;
        });
      }
    });

    controller.forward().then((_) {
      controller.dispose();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final toastStyle = ToastTheme.getStyle(widget.request.type, theme);
    final contentColor = ToastTheme.getContentColor(widget.request.type, theme);
    final isTop = widget.request.position == ToastPosition.top;

    // 顶部/底部安全区域
    final padding = MediaQuery.of(context).padding;
    final safeMargin = isTop ? padding.top + 16 : padding.bottom + 16;

    // 计算透明度（拖拽时根据距离渐变）
    final dragOpacity = _isDragging || _isDismissedByGesture
        ? (1.0 - (_dragOffset.abs() / 200.0)).clamp(0.3, 1.0)
        : 1.0;

    return Positioned(
      top: isTop ? safeMargin : null,
      bottom: isTop ? null : safeMargin,
      left: 16,
      right: 16,
      child: Center(
        child: GestureDetector(
          onVerticalDragStart: widget.isEntering ? _onDragStart : null,
          onVerticalDragUpdate: widget.isEntering ? _onDragUpdate : null,
          onVerticalDragEnd: widget.isEntering ? _onDragEnd : null,
          child: AnimatedBuilder(
            animation: Listenable.merge([_slideAnimation, _fadeAnimation]),
            builder: (context, child) {
              // 组合动画偏移和手势拖拽偏移
              final animOffset = _slideAnimation.value;
              final totalOffsetY = animOffset.dy * 100 + _dragOffset;

              return Transform.translate(
                offset: Offset(0, totalOffsetY),
                child: Opacity(
                  opacity: _fadeAnimation.value * dragOpacity,
                  child: child,
                ),
              );
            },
            child: ToastContent(
              request: widget.request,
              style: toastStyle,
              contentColor: contentColor,
              isExiting: !widget.isEntering,
            ),
          ),
        ),
      ),
    );
  }
}
