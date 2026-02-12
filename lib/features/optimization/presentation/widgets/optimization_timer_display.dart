import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/optimization_state.dart';
import '../providers/optimization_provider.dart';

/// 优化过程中的计时器小部件
///
/// 监听 [optimizationProvider] 的状态变化，并显示两个计时器：
/// 1. 网络响应计时器：从优化开始到收到第一个响应块。
/// 2. 总时长计时器：从优化开始到整个过程结束。
///
/// 当网络响应到达时，它会触发一个动画：网络计时器向左滑动，总计时器渐显、上移并放大。
class OptimizationTimerDisplay extends ConsumerStatefulWidget {
  final Color? color;
  final double fontSize;

  const OptimizationTimerDisplay({super.key, this.color, this.fontSize = 17});

  @override
  ConsumerState<OptimizationTimerDisplay> createState() =>
      _OptimizationTimerDisplayState();
}

class _OptimizationTimerDisplayState
    extends ConsumerState<OptimizationTimerDisplay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _networkTimerSlide;
  late final Animation<double> _totalTimerFade;
  late final Animation<Offset> _totalTimerSlide;
  late final Animation<double> _totalTimerScale;

  bool _showTotalTimer = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    // 网络计时器向左平移
    _networkTimerSlide =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.6, 0.0)).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );

    // 总计时器：渐显、上移、放大
    _totalTimerFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
    _totalTimerSlide =
        Tween<Offset>(
          begin: const Offset(0.0, 0.8), // 从下方上移
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );
    _totalTimerScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // 监听状态变化以触发动画或重置
    ref.listenManual<OptimizationState>(optimizationProvider, (prev, next) {
      // 动画触发条件：网络响应时间首次出现
      if (next.networkResponseTime != null &&
          (prev?.networkResponseTime == null || !_showTotalTimer)) {
        if (mounted) {
          setState(() {
            _showTotalTimer = true;
          });
          _controller.forward();
        }
      }

      // 重置条件：开始新的优化时
      final wasProcessing = prev?.isProcessing ?? false;
      if (!wasProcessing && next.isProcessing) {
        if (mounted) {
          setState(() {
            _showTotalTimer = false;
          });
          _controller.reset();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    return '${(d.inMilliseconds / 1000).toStringAsFixed(1)}s';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(optimizationProvider);

    // 只要优化流程启动过，就显示计时器，直到被清除
    if (state.startTime == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.primary;
    final textStyle = TextStyle(
      fontSize: widget.fontSize,
      color: widget.color ?? defaultColor,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    final boldTextStyle = textStyle.copyWith(fontWeight: FontWeight.bold);

    final networkDuration = state.networkResponseTime != null
        ? state.networkResponseTime!.difference(state.startTime!)
        : state.currentDuration;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: widget.fontSize + 4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 网络响应计时器
              Positioned(
                child: SlideTransition(
                  position: _networkTimerSlide,
                  child: Text(
                    _formatDuration(networkDuration),
                    style: textStyle,
                  ),
                ),
              ),
              // 总时长计时器
              if (_showTotalTimer)
                Positioned(
                  child: FadeTransition(
                    opacity: _totalTimerFade,
                    child: SlideTransition(
                      position: _totalTimerSlide,
                      child: ScaleTransition(
                        scale: _totalTimerScale,
                        child: Padding(
                          padding: EdgeInsets.only(left: widget.fontSize * 3),
                          child: Text(
                            _formatDuration(state.currentDuration),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
