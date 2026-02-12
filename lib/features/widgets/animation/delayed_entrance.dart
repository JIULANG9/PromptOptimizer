import 'package:flutter/material.dart';

/// 带延迟的入场动画 Widget
///
/// 封装 FadeTransition + SlideTransition 组合，实现"渐显 + 微微上滑"效果。
/// 通过 [delay] 控制动画启动时机，配合多个实例可实现顺序入场效果。
///
/// 用法示例：
/// ```dart
/// DelayedEntrance(
///   controller: _animController,
///   delay: 0.0,        // 0ms 开始
///   child: MyWidget(),
/// )
/// ```
///
/// 配合 [StaggeredEntrance] 可更方便地为一组子组件设置顺序入场动画。
class DelayedEntrance extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 父级动画控制器（由页面统一管理）
  final AnimationController controller;

  /// 动画在 controller 时间轴中的起始比例 [0.0, 1.0)
  final double delay;

  /// 动画在 controller 时间轴中的结束比例 (0.0, 1.0]
  final double end;

  /// 上滑偏移量（像素），默认 20px
  final double slideOffset;

  /// 动画曲线
  final Curve curve;

  const DelayedEntrance({
    super.key,
    required this.child,
    required this.controller,
    this.delay = 0.0,
    this.end = 1.0,
    this.slideOffset = 20.0,
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    // 在 controller 的 [delay, end] 区间内插值
    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(delay, end, curve: curve),
    );

    // 透明度：0 → 1
    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    // 位移：从下方 slideOffset 处滑入到原位
    final slideAnimation = Tween<Offset>(
      begin: Offset(0, slideOffset),
      end: Offset.zero,
    ).animate(curvedAnimation);

    return FadeTransition(
      opacity: fadeAnimation,
      child: AnimatedBuilder(
        animation: slideAnimation,
        builder: (context, child) =>
            Transform.translate(offset: slideAnimation.value, child: child),
        child: child,
      ),
    );
  }
}

/// 顺序入场动画容器
///
/// 为一组子组件自动分配延迟时间，实现顺序入场效果。
/// 页面首次进入时自动触发动画，后续不再重复播放。
///
/// [staggerDelay] 控制相邻组件之间的延迟间隔（毫秒），
/// 统一修改此值即可调整整体入场节奏。
///
/// 用法示例：
/// ```dart
/// StaggeredEntrance(
///   staggerDelay: 100,  // 每个组件间隔 100ms
///   children: [
///     PromptTabBar(...),    // 0ms 入场
///     ControlPanel(),       // 100ms 入场
///     PromptInput(...),     // 200ms 入场
///   ],
///   builder: (context, animatedChildren) {
///     return Column(children: animatedChildren);
///   },
/// )
/// ```
class StaggeredEntrance extends StatefulWidget {
  /// 需要顺序入场的子组件列表
  final List<Widget> children;

  /// 构建器：接收包裹了动画的子组件列表，返回最终布局
  final Widget Function(BuildContext context, List<Widget> animatedChildren)
  builder;

  /// 相邻组件之间的延迟间隔（毫秒）
  final int staggerDelay;

  /// 整体动画时长（毫秒），包含所有子组件的入场时间
  final int totalDuration;

  /// 每个子组件的上滑偏移量（像素）
  final double slideOffset;

  /// 动画曲线
  final Curve curve;

  const StaggeredEntrance({
    super.key,
    required this.children,
    required this.builder,
    this.staggerDelay = 100,
    this.totalDuration = 600,
    this.slideOffset = 20.0,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.totalDuration),
    );
    // 页面首次进入时自动触发
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.children.length;
    if (count == 0) return widget.builder(context, []);

    // 计算每个子组件在 [0.0, 1.0] 时间轴上的起止区间
    // 最后一个子组件的 delay = (count-1) * staggerDelay
    // totalDuration 需要覆盖所有 delay + 单个动画播放时间
    final totalMs = widget.totalDuration;

    final animatedChildren = <Widget>[];
    for (int i = 0; i < count; i++) {
      final delayMs = i * widget.staggerDelay;
      // 将毫秒转换为 [0.0, 1.0] 的比例
      final delayRatio = (delayMs / totalMs).clamp(0.0, 0.99);
      // 每个子组件的动画结束点：从 delay 开始，占据剩余时间
      // 确保最后一个子组件也有足够的动画时间
      final endRatio = 1.0;

      animatedChildren.add(
        DelayedEntrance(
          controller: _controller,
          delay: delayRatio,
          end: endRatio,
          slideOffset: widget.slideOffset,
          curve: widget.curve,
          child: widget.children[i],
        ),
      );
    }

    return widget.builder(context, animatedChildren);
  }
}
