import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../database/daos/ai_app_config_dao.dart';
import '../models/ai_app_config.dart';

/// AI 应用配置仓库
/// 负责协调数据访问和业务逻辑
/// 内置应用从 AppConstants 读取，自定义应用从数据库读取
class AIAppRepository {
  final AIAppConfigDao _dao;
  late final Box<bool> _enabledStatesBox;

  AIAppRepository(this._dao) {
    _enabledStatesBox = Hive.box<bool>('ai_app_enabled_states');
  }

  /// 获取所有 AI 应用配置（内置 + 自定义）
  Future<List<AIAppConfigModel>> getAllApps() async {
    try {
      final customApps = await _dao.getAllApps();
      final builtinApps = _getBuiltinApps();
      return [...builtinApps, ...customApps.map((app) => AIAppConfigModel.fromDrift(app))];
    } catch (e) {
      throw Exception('获取应用列表失败: $e');
    }
  }

  /// 获取内置应用列表
  List<AIAppConfigModel> _getBuiltinApps() {
    return AppConstants.builtInAIApps.asMap().entries.map((entry) {
      final index = entry.key;
      final app = entry.value;
      final name = app['name']!;
      final isEnabled = _enabledStatesBox.get(name, defaultValue: true) ?? true;
      return AIAppConfigModel.fromBuiltin(
        builtinConfig: app,
        position: index,
        isEnabled: isEnabled,
      );
    }).toList();
  }

  /// 监听所有 AI 应用配置变化（内置 + 自定义）
  Stream<List<AIAppConfigModel>> watchAllApps() {
    return _dao.watchAllApps().map((customApps) {
      final builtinApps = _getBuiltinApps();
      return [...builtinApps, ...customApps.map((app) => AIAppConfigModel.fromDrift(app))];
    });
  }

  /// 获取已启用的 AI 应用配置（按 position 排序）
  Future<List<AIAppConfigModel>> getEnabledApps() async {
    try {
      final allApps = await getAllApps();
      final enabledApps = allApps.where((app) => app.isEnabled).toList();
      enabledApps.sort((a, b) => a.position.compareTo(b.position));
      return enabledApps;
    } catch (e) {
      throw Exception('获取已启用应用失败: $e');
    }
  }

  /// 监听已启用的 AI 应用配置（按 position 排序）
  Stream<List<AIAppConfigModel>> watchEnabledApps() {
    return watchAllApps().map((allApps) {
      final enabledApps = allApps.where((app) => app.isEnabled).toList();
      enabledApps.sort((a, b) => a.position.compareTo(b.position));
      return enabledApps;
    });
  }

  /// 根据 ID 获取 AI 应用配置
  Future<AIAppConfigModel?> getAppById(String id) async {
    try {
      // 先检查是否为内置应用
      if (id.startsWith('builtin_')) {
        final allApps = await getAllApps();
        return allApps.firstWhere((app) => app.id == id);
      }
      // 自定义应用从数据库获取
      final app = await _dao.getAppById(id);
      return app != null ? AIAppConfigModel.fromDrift(app) : null;
    } catch (e) {
      throw Exception('获取应用详情失败: $e');
    }
  }

  /// 切换应用启用状态
  Future<void> toggleAppEnabled(String id) async {
    try {
      // 内置应用：更新 Hive 状态
      if (id.startsWith('builtin_')) {
        final app = await getAppById(id);
        if (app == null) throw Exception('应用不存在');
        await _enabledStatesBox.put(app.name, !app.isEnabled);
        return;
      }
      // 自定义应用：更新数据库
      final app = await _dao.getAppById(id);
      if (app == null) throw Exception('应用不存在');
      await _dao.toggleAppEnabled(id, !app.isEnabled);
    } catch (e) {
      throw Exception('切换应用状态失败: $e');
    }
  }

  /// 更新应用排序位置
  Future<void> updateAppPosition(String id, int newPosition) async {
    try {
      final success = await _dao.updateAppPosition(id, newPosition);
      if (!success) {
        throw Exception('应用不存在');
      }
    } catch (e) {
      throw Exception('更新应用位置失败: $e');
    }
  }

  /// 批量更新应用排序位置
  Future<void> updateAppPositions(Map<String, int> positions) async {
    try {
      await _dao.updateAppPositions(positions);
    } catch (e) {
      throw Exception('批量更新应用位置失败: $e');
    }
  }

  /// 添加自定义应用
  Future<void> addCustomApp({
    required String id,
    required String name,
    required String scheme,
    required String iconPath,
  }) async {
    try {
      // 获取当前最大 position
      final allApps = await _dao.getAllApps();
      final maxPosition =
          allApps.isEmpty ? 0 : allApps.map((app) => app.position).reduce((a, b) => a > b ? a : b);

      final app = AIAppConfigModel(
        id: id,
        name: name,
        scheme: scheme,
        iconPath: iconPath,
        isEnabled: true,
        position: maxPosition + 1,
        isBuiltin: false,
        createdAt: DateTime.now(),
      );

      await _dao.insertApp(app.toCompanion());
    } catch (e) {
      throw Exception('添加自定义应用失败: $e');
    }
  }

  /// 删除应用（仅允许删除自定义应用）
  Future<void> deleteApp(String id) async {
    try {
      if (id.startsWith('builtin_')) {
        throw Exception('不能删除内置应用');
      }
      await _dao.deleteApp(id);
    } catch (e) {
      throw Exception('删除应用失败: $e');
    }
  }
}
