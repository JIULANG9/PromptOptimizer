import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 应用主题构建器
/// 基于 Material Design 3，使用 AppColors 统一颜色 Token
/// 禁止在此文件外部直接构建 ThemeData
class AppTheme {
  AppTheme._();

  /// 浅色主题
  static ThemeData lightTheme() {
    final colorScheme = AppColors.lightColorScheme;
    return _buildTheme(colorScheme, Brightness.light);
  }

  /// 深色主题
  static ThemeData darkTheme() {
    final colorScheme = AppColors.darkColorScheme;
    return _buildTheme(colorScheme, Brightness.dark);
  }

  /// 通用主题构建逻辑
  static ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    final isLight = brightness == Brightness.light;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,

      // ─── 页面转场动画 ───
      // PC（Windows/Linux）使用淡入上移，移动端（Android/iOS/macOS）使用 Cupertino 滑动
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        },
      ),

      // ─── 脚手架 ───
      scaffoldBackgroundColor: Colors.transparent,

      // ─── AppBar ───
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // ─── 卡片 ───
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: isLight ? 1 : 2,
        shadowColor: isLight
            ? AppColors.lightCardShadow
            : AppColors.darkCardShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // ─── 输入框 ───
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),

      // ─── 按钮 ───
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // ─── 文本按钮 ───
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      // ─── 浮动按钮 ───
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // ─── 列表项 ───
      listTileTheme: ListTileThemeData(
        tileColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      // ─── 分割线 ───
      dividerTheme: DividerThemeData(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
        thickness: 1,
      ),

      // ─── 对话框 ───
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // ─── SnackBar ───
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.onSurface,
        contentTextStyle: TextStyle(color: colorScheme.surface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      // ─── Chip ───
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        selectedColor: colorScheme.primary.withValues(alpha: 0.15),
        labelStyle: TextStyle(color: colorScheme.onSurface, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
