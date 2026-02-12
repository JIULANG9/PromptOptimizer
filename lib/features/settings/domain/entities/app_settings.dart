/// 主题模式设置枚举
/// 对应 Hive 存储的字符串值: 'system', 'light', 'dark'
enum ThemeModeSetting {
  system,
  light,
  dark;

  /// 从存储字符串转换
  static ThemeModeSetting fromString(String value) {
    switch (value) {
      case 'light':
        return ThemeModeSetting.light;
      case 'dark':
        return ThemeModeSetting.dark;
      default:
        return ThemeModeSetting.system;
    }
  }

  /// 转换为存储字符串
  String toStorageString() => name;
}

/// 应用 UI 偏好设置（存储于 Hive）
/// 仅包含表现层相关的偏好，不包含业务数据
class AppSettings {
  final ThemeModeSetting themeMode;
  final String locale;

  const AppSettings({
    this.themeMode = ThemeModeSetting.system,
    this.locale = 'zh',
  });

  /// 创建副本并覆盖指定字段
  AppSettings copyWith({ThemeModeSetting? themeMode, String? locale}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
