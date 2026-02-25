import 'package:flutter/material.dart';

import '../../data/models/ai_app_config.dart';
import 'ai_app_button.dart';

/// 动画模式枚举
enum AnimationMode {
  /// 单个按钮模式 - 立即启动动画
  single,
  /// 多个按钮模式 - 阶梯式延迟启动
  multiple,
}

/// 带动画的 AI 应用按钮
/// 支持单个和多个按钮两种模式的进入/退出动画
class AnimatedAIAppButton extends StatefulWidget {
  final AIAppConfigModel app;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final VoidCallback? onAdd;
  final bool showCloseButton;
  final bool showAddButton;
  
  /// 动画模式
  final AnimationMode mode;
  
  /// 在多个按钮模式下，该按钮的索引（用于计算延迟）
  final int index;
  
  /// 是否触发关闭动画
  final bool triggerCloseAnimation;
  
  /// 关闭动画完成回调
  final VoidCallback? onCloseAnimationComplete;

  const AnimatedAIAppButton({
    super.key,
    required this.app,
    required this.onTap,
    this.onClose,
    this.onAdd,
    this.showCloseButton = false,
    this.showAddButton = false,
    this.mode = AnimationMode.single,
    this.index = 0,
    this.triggerCloseAnimation = false,
    this.onCloseAnimationComplete,
  });

  @override
  State<AnimatedAIAppButton> createState() => _AnimatedAIAppButtonState();
}

class _AnimatedAIAppButtonState extends State<AnimatedAIAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.6), // 9px 上移
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startAnimation();
  }

  void _startAnimation() {
    if (widget.triggerCloseAnimation) {
      // 关闭动画：逆推
      _controller.reverse();
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onCloseAnimationComplete?.call();
        }
      });
    } else {
      // 进入动画
      final delay = _calculateDelay();
      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  /// 计算动画延迟时间
  int _calculateDelay() {
    switch (widget.mode) {
      case AnimationMode.single:
        // 单个按钮模式：立即启动
        return 0;
      case AnimationMode.multiple:
        // 多个按钮模式：第一个立即启动，后续每个延迟 100ms
        return widget.index * 100;
    }
  }

  @override
  void didUpdateWidget(AnimatedAIAppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 如果关闭动画状态改变，重新启动动画
    if (oldWidget.triggerCloseAnimation != widget.triggerCloseAnimation) {
      _controller.reset();
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: AIAppButton(
          app: widget.app,
          onTap: widget.onTap,
          onClose: widget.onClose,
          onAdd: widget.onAdd,
          showCloseButton: widget.showCloseButton,
          showAddButton: widget.showAddButton,
        ),
      ),
    );
  }
}
