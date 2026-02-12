import 'package:hive_flutter/hive_flutter.dart';

import '../domain/entities/app_settings.dart';

/// 设置仓库 — 封装 Hive 读写细节
/// 领域层通过此仓库访问 UI 偏好设置，不直接操作 Hive
class SettingsRepository {
  final Box _box;

  // Hive 存储键名
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLocale = 'locale';
  static const String _keySelectedApiConfigId = 'selected_api_config_id';
  static const String _keySelectedUserTemplateId = 'selected_user_template_id';
  static const String _keySelectedSystemTemplateId =
      'selected_system_template_id';

  SettingsRepository(this._box);

  /// 读取当前设置，若无存储值则返回默认值
  AppSettings getSettings() {
    final themeModeStr =
        _box.get(_keyThemeMode, defaultValue: 'system') as String;
    final locale = _box.get(_keyLocale, defaultValue: 'zh') as String;

    return AppSettings(
      themeMode: ThemeModeSetting.fromString(themeModeStr),
      locale: locale,
    );
  }

  /// 保存主题模式
  Future<void> saveThemeMode(ThemeModeSetting mode) async {
    await _box.put(_keyThemeMode, mode.toStorageString());
  }

  /// 保存语言设置
  Future<void> saveLocale(String locale) async {
    await _box.put(_keyLocale, locale);
  }

  // ─── 选择持久化 ───

  /// 读取上次选择的 API 配置 ID
  String? getSelectedApiConfigId() {
    return _box.get(_keySelectedApiConfigId) as String?;
  }

  /// 保存选择的 API 配置 ID
  Future<void> saveSelectedApiConfigId(String? id) async {
    if (id == null) {
      await _box.delete(_keySelectedApiConfigId);
    } else {
      await _box.put(_keySelectedApiConfigId, id);
    }
  }

  /// 读取上次选择的模板 ID（按 tab 类型区分）
  String? getSelectedTemplateId(String tabType) {
    final key = tabType == 'userOptimize'
        ? _keySelectedUserTemplateId
        : _keySelectedSystemTemplateId;
    return _box.get(key) as String?;
  }

  /// 保存选择的模板 ID（按 tab 类型区分）
  Future<void> saveSelectedTemplateId(String tabType, String? id) async {
    final key = tabType == 'userOptimize'
        ? _keySelectedUserTemplateId
        : _keySelectedSystemTemplateId;
    if (id == null) {
      await _box.delete(key);
    } else {
      await _box.put(key, id);
    }
  }
}
