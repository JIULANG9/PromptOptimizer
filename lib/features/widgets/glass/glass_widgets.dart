import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 全局极光渐变背景层
/// 使用多层径向渐变叠加，模拟左上角极光光晕效果
/// - 深色模式：品红 + 蓝紫 + 青色光晕，深黑底色
/// - 浅色模式：淡粉 + 淡紫 + 淡青光晕，柔白底色
class GlassBackground extends StatelessWidget {
  final Widget child;

  const GlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 底色层
        ColoredBox(
          color: isLight ? AppColors.lightAuroraBase : AppColors.darkAuroraBase,
        ),
        // 极光光晕层 1 — 品红/淡粉（左上偏上）
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.8, -1.0),
                radius: isLight ? 1.0 : 0.8,
                colors: isLight
                    ? [
                        AppColors.lightAuroraPink.withValues(alpha: 0.7),
                        AppColors.lightAuroraPink.withValues(alpha: 0.0),
                      ]
                    : [
                        AppColors.darkAuroraMagenta.withValues(alpha: 0.6),
                        AppColors.darkAuroraMagenta.withValues(alpha: 0.0),
                      ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),
        // 极光光晕层 2 — 蓝紫/淡紫（左上偏中）
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.6, -0.5),
                radius: isLight ? 1.2 : 0.9,
                colors: isLight
                    ? [
                        AppColors.lightAuroraLavender.withValues(alpha: 0.6),
                        AppColors.lightAuroraLavender.withValues(alpha: 0.0),
                      ]
                    : [
                        AppColors.darkAuroraBlue.withValues(alpha: 0.55),
                        AppColors.darkAuroraBlue.withValues(alpha: 0.0),
                      ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),
        // 极光光晕层 3 — 青色/淡青（左上偏左下）
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-1.0, -0.2),
                radius: isLight ? 0.8 : 0.6,
                colors: isLight
                    ? [
                        AppColors.lightAuroraMint.withValues(alpha: 0.5),
                        AppColors.lightAuroraMint.withValues(alpha: 0.0),
                      ]
                    : [
                        AppColors.darkAuroraCyan.withValues(alpha: 0.4),
                        AppColors.darkAuroraCyan.withValues(alpha: 0.0),
                      ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),
        // 内容层
        child,
      ],
    );
  }
}

/// 毛玻璃页面脚手架
/// 每个页面独立拥有背景图 + Scaffold，避免页面转场时背景穿帮
/// 用法：直接替换 Scaffold，参数与 Scaffold 一致
class GlassScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;

  const GlassScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      ),
    );
  }
}

/// 毛玻璃容器组件
/// 封装 BackdropFilter + 半透明背景，实现统一的 frosted glass 效果
/// 所有需要毛玻璃效果的卡片/面板统一使用此组件
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  /// 模糊强度
  final double blurSigma;

  /// 背景透明度（浅色模式）
  final double lightOpacity;

  /// 背景透明度（深色模式）
  final double darkOpacity;

  const GlassCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius,
    this.blurSigma = 20,
    this.lightOpacity = 0.6,
    this.darkOpacity = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final radius = borderRadius ?? BorderRadius.circular(16);

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: isLight
                  ? Colors.white.withValues(alpha: lightOpacity)
                  : Colors.black.withValues(alpha: darkOpacity),
              borderRadius: radius,
              border: Border.all(
                color: isLight
                    ? Colors.white.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
