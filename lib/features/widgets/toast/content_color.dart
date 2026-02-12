import 'package:flutter/material.dart';

/// 提供内容颜色的 InheritedWidget
/// 类似于 Jetpack Compose 的 LocalContentColor
class LocalContentColor extends InheritedWidget {
  final Color color;

  const LocalContentColor({
    super.key,
    required this.color,
    required super.child,
  });

  /// 获取当前上下文的内容颜色
  /// 如果未找到，则返回主题的 onSurface 颜色
  static Color current(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<LocalContentColor>();
    return provider?.color ?? Theme.of(context).colorScheme.onSurface;
  }

  @override
  bool updateShouldNotify(LocalContentColor oldWidget) {
    return color != oldWidget.color;
  }
}
