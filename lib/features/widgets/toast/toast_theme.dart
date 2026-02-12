import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'content_color.dart';
import 'toast_models.dart';

/// Toast 样式配置
class ToastTheme {
  final Color backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;

  const ToastTheme({
    required this.backgroundColor,
    this.textColor,
    this.icon,
    this.iconColor,
  });

  /// 获取当前上下文的内容颜色
  /// 类似于 Jetpack Compose 的 LocalContentColor.current
  static Color contentColor(BuildContext context) {
    return LocalContentColor.current(context);
  }

  /// 获取指定类型的样式
  static ToastTheme getStyle(ToastType type, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    switch (type) {
      case ToastType.success:
        return ToastTheme(
          backgroundColor: AppColors.success,
          textColor: Colors.white,
          icon: Icons.check_circle_rounded,
          iconColor: Colors.white,
        );
      case ToastType.warning:
        return ToastTheme(
          backgroundColor: isDark
              ? const Color(0xFF5D4037)
              : const Color(0xFFFFF3E0),
          textColor: isDark ? const Color(0xFFFFCC80) : const Color(0xFFEF6C00),
          icon: Icons.warning_rounded,
          iconColor: isDark ? const Color(0xFFFFCC80) : const Color(0xFFEF6C00),
        );
      case ToastType.error:
        return ToastTheme(
          backgroundColor: isDark
              ? colorScheme.errorContainer
              : colorScheme.error,
          textColor: isDark
              ? colorScheme.onErrorContainer
              : colorScheme.onError,
          icon: Icons.error_rounded,
          iconColor: isDark
              ? colorScheme.onErrorContainer
              : colorScheme.onError,
        );
      case ToastType.info:
        return ToastTheme(
          backgroundColor: isDark ? colorScheme.primary : colorScheme.primary,
          textColor: Colors.white,
          icon: Icons.info_rounded,
          iconColor: Colors.white,
        );
      case ToastType.progress:
        return ToastTheme(
          backgroundColor: isDark
              ? colorScheme.surface
              : colorScheme.surfaceContainerHighest,
          textColor: colorScheme.onSurface,
          icon: null, // 进度类型单独处理图标
        );
      case ToastType.normal:
        return ToastTheme(
          backgroundColor: isDark
              ? colorScheme.surface
              : colorScheme.surfaceContainerHighest,
          textColor: colorScheme.onSurface,
          icon: null,
        );
    }
  }

  /// 获取指定类型的内容颜色
  static Color getContentColor(ToastType type, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    switch (type) {
      case ToastType.success:
        return Colors.white;
      case ToastType.warning:
        return isDark ? const Color(0xFFFFCC80) : const Color(0xFFEF6C00);
      case ToastType.error:
        return isDark ? colorScheme.onErrorContainer : colorScheme.onError;
      case ToastType.info:
        return Colors.white;
      case ToastType.progress:
        return theme.textTheme.bodyMedium?.color ?? Colors.black;
      case ToastType.normal:
        return Colors.white;
    }
  }

  /// 默认动画时长
  static const Duration defaultDuration = Duration(milliseconds: 2500);
  static const Duration longDuration = Duration(milliseconds: 4000);
  static const Duration animationDuration = Duration(milliseconds: 400);

  /// 默认圆角
  static const double pillRadius = 100.0;
  static const double rectRadius = 25.0;
}
