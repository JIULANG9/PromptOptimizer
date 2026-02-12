import 'package:flutter/material.dart';

/// 应用统一颜色 Token 定义
/// 所有颜色值集中管理，禁止在 Widget 中硬编码十六进制颜色
/// 设计规范来源: Documentation/界面设计文档.md
abstract class AppColors {
  // ─── 浅色模式 (Light Mode) — 科技蓝调 ───
  static const Color lightPrimary = Color(0xFF635cfa);
  static const Color lightSecondary = Color(0xFFaeaafd);
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Color(0xFFFEFEFE);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightOnSurfaceVariant = Color(0xFF666666);
  static const Color lightCardShadow = Color(0x0D000000); // rgba(0,0,0,0.05)
  static const Color lightPrimaryText = Color(0xFF262F59);
  static const Color lightSecondaryText = Color(0xFF8b90a6);

  // ─── 深色模式 (Dark Mode) — 科技蓝调 ───
  static const Color darkPrimary = Color(0xFF635cfa);
  static const Color darkSecondary = Color(0xFFaeaafd);
  static const Color darkBackground = Color(0xFF0e0e0c);
  static const Color darkSurface = Color(0xFF262624);
  static const Color darkOnSurface = Color(0xFFE0E6F1);
  static const Color darkOnSurfaceVariant = Color(0xFF8892B0);
  static const Color darkCardShadow = Color(0x33000000); // rgba(0,0,0,0.2)

  // ─── 极光渐变背景色 (Aurora Gradient Background) ───
  // 深色模式：左上角极光光晕（品红 → 蓝紫 → 青色），其余区域深黑
  static const Color darkAuroraMagenta = Color(0xFFE040FB); // 品红/洋红
  static const Color darkAuroraBlue = Color(0xFF5C3FE6); // 蓝紫
  static const Color darkAuroraCyan = Color(0xFF00BCD4); // 青色
  static const Color darkAuroraBase = Color(0xFF080810); // 深黑底色

  // 浅色模式：左上角柔和极光光晕（淡粉 → 淡紫 → 淡青），其余区域柔白
  static const Color lightAuroraPink = Color(0xFFF3C4FB); // 淡粉
  static const Color lightAuroraLavender = Color(0xFFD4C4FB); // 淡紫
  static const Color lightAuroraMint = Color(0xFFB2EBF2); // 淡青
  static const Color lightAuroraBase = Color(0xFFF5F7FA); // 柔白底色

  // ─── 通用语义色（Light/Dark 共用） ───
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA726);

  /// 构建浅色模式 ColorScheme
  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: Colors.white,
    secondary: lightSecondary,
    onSecondary: Colors.white,
    error: error,
    onError: Colors.white,
    surface: lightSurface,
    onSurface: lightOnSurface,
    onSurfaceVariant: lightOnSurfaceVariant,
    surfaceContainerHighest: lightBackground,
  );

  /// 构建深色模式 ColorScheme
  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: Colors.white,
    secondary: darkSecondary,
    onSecondary: Colors.white,
    error: error,
    onError: Colors.white,
    surface: darkSurface,
    onSurface: darkOnSurface,
    onSurfaceVariant: darkOnSurfaceVariant,
    surfaceContainerHighest: darkBackground,
  );
}
