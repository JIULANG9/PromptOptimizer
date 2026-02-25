import '../../../../database/daos/ai_app_config_dao.dart';
import '../../../../database/seed/default_ai_apps.dart';
import '../models/ai_app_config.dart';

/// AI 应用配置仓库
/// 负责协调数据访问和业务逻辑
class AIAppRepository {
  final AIAppConfigDao _dao;

  AIAppRepository(this._dao);

  /// 获取所有 AI 应用配置
  Future<List<AIAppConfigModel>> getAllApps() async {
    try {
      final apps = await _dao.getAllApps();
      return apps.map((app) => AIAppConfigModel.fromDrift(app)).toList();
    } catch (e) {
      throw Exception('获取应用列表失败: $e');
    }
  }

  /// 监听所有 AI 应用配置变化
  Stream<List<AIAppConfigModel>> watchAllApps() {
    return _dao.watchAllApps().map(
          (apps) => apps.map((app) => AIAppConfigModel.fromDrift(app)).toList(),
        );
  }

  /// 获取已启用的 AI 应用配置（按 position 排序）
  Future<List<AIAppConfigModel>> getEnabledApps() async {
    try {
      final apps = await _dao.getEnabledApps();
      return apps.map((app) => AIAppConfigModel.fromDrift(app)).toList();
    } catch (e) {
      throw Exception('获取已启用应用失败: $e');
    }
  }

  /// 监听已启用的 AI 应用配置（按 position 排序）
  Stream<List<AIAppConfigModel>> watchEnabledApps() {
    return _dao.watchEnabledApps().map(
          (apps) => apps.map((app) => AIAppConfigModel.fromDrift(app)).toList(),
        );
  }

  /// 根据 ID 获取 AI 应用配置
  Future<AIAppConfigModel?> getAppById(String id) async {
    try {
      final app = await _dao.getAppById(id);
      return app != null ? AIAppConfigModel.fromDrift(app) : null;
    } catch (e) {
      throw Exception('获取应用详情失败: $e');
    }
  }

  /// 切换应用启用状态
  Future<void> toggleAppEnabled(String id) async {
    try {
      final app = await _dao.getAppById(id);
      if (app == null) {
        throw Exception('应用不存在');
      }
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

  /// 删除应用
  Future<void> deleteApp(String id) async {
    try {
      await _dao.deleteApp(id);
    } catch (e) {
      throw Exception('删除应用失败: $e');
    }
  }

  /// 初始化默认应用（仅在数据库为空时执行）
  Future<void> initializeDefaultApps() async {
    try {
      final isEmpty = await _dao.isEmpty();
      if (isEmpty) {
        await _dao.insertApps(defaultAIApps);
      }
    } catch (e) {
      throw Exception('初始化默认应用失败: $e');
    }
  }
}
