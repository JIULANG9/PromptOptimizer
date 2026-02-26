import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../data/models/ai_app_config.dart';
import '../../data/repositories/ai_app_repository.dart';
import '../../domain/usecases/launch_ai_app_usecase.dart';
import '../../domain/usecases/open_app_store_usecase.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../../widgets/toast/toast_models.dart';

/// AI 应用配置 Provider
/// 提供 AIAppRepository 实例
final aiAppRepositoryProvider = Provider<AIAppRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return AIAppRepository(database.aIAppConfigDao);
}, dependencies: [appDatabaseProvider]);

/// AI 应用列表 Provider
/// 监听所有 AI 应用配置
final aIAppListProvider = StreamProvider<List<AIAppConfigModel>>((ref) {
  final repository = ref.watch(aiAppRepositoryProvider);
  return repository.watchAllApps();
}, dependencies: [aiAppRepositoryProvider, appDatabaseProvider]);

/// 已启用 AI 应用列表 Provider
/// 监听已启用的 AI 应用配置（按 position 排序）
final enabledAIAppListProvider = StreamProvider<List<AIAppConfigModel>>((ref) {
  final repository = ref.watch(aiAppRepositoryProvider);
  return repository.watchEnabledApps();
}, dependencies: [aiAppRepositoryProvider, appDatabaseProvider]);

/// AI 应用管理 Notifier
class AIAppManager extends AsyncNotifier<void> {
  late AIAppRepository _repository;
  late LaunchAIAppUseCase _launchUseCase;
  late OpenAppStoreUseCase _openStoreUseCase;

  @override
  Future<void> build() async {
    _repository = ref.watch(aiAppRepositoryProvider);
    _launchUseCase = LaunchAIAppUseCase();
    _openStoreUseCase = OpenAppStoreUseCase();
  }

  /// 切换应用启用状态
  Future<void> toggleAppEnabled(String id) async {
    try {
      await _repository.toggleAppEnabled(id);
    } catch (e) {
      _showErrorToast('切换应用状态失败');
    }
  }

  /// 更新应用排序位置
  Future<void> updateAppPosition(String id, int newPosition) async {
    try {
      await _repository.updateAppPosition(id, newPosition);
    } catch (e) {
      _showErrorToast('更新应用位置失败');
    }
  }

  /// 批量更新应用排序位置
  Future<void> updateAppPositions(Map<String, int> positions) async {
    try {
      await _repository.updateAppPositions(positions);
    } catch (e) {
      _showErrorToast('更新应用位置失败');
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
      await _repository.addCustomApp(
        id: id,
        name: name,
        scheme: scheme,
        iconPath: iconPath,
      );
      _showSuccessToast('添加应用成功');
    } catch (e) {
      _showErrorToast('添加应用失败');
    }
  }

  /// 删除应用
  Future<void> deleteApp(String id) async {
    try {
      await _repository.deleteApp(id);
      _showSuccessToast('删除应用成功');
    } catch (e) {
      _showErrorToast('删除应用失败');
    }
  }

  /// 启动 AI 应用
  /// 
  /// [id] 应用 ID
  /// [promptText] 要复制到剪贴板的提示词文本
  Future<void> launchApp(String id, String promptText) async {
    try {
      // 获取应用配置
      final app = await _repository.getAppById(id);
      if (app == null) {
        _showErrorToast('应用不存在');
        return;
      }

      // 启动应用（优先 Scheme 跳转，失败则用包名兜底）
      final success = await _launchUseCase(
        scheme: app.actualScheme,
        promptText: promptText,
        packageName: app.actualPackageName,
      );

      if (success) {
        _showSuccessToast('已复制到剪贴板并跳转');
      } else {
        // 应用未安装，显示 Action Toast
        _showAppNotInstalledToast(app.name);
      }
    } catch (e) {
      _showErrorToast('跳转失败');
    }
  }

  /// 显示成功提示
  void _showSuccessToast(String message) {
    ref.read(toastProvider.notifier).showSuccess(message);
  }

  /// 显示错误提示
  void _showErrorToast(String message) {
    ref.read(toastProvider.notifier).showError(message);
  }

  /// 显示应用未安装提示（带下载按钮）
  void _showAppNotInstalledToast(String appName) {
    ref.read(toastProvider.notifier).showAction(
          message: '该应用未安装，是否前往应用商店下载？',
          type: ToastType.warning,
          primaryAction: ToastAction(
            label: '去下载',
            onPressed: () async {
              final success = await _openStoreUseCase(appName);
              if (!success) {
                _showErrorToast('打开应用商店失败');
              }
            },
          ),
          duration: const Duration(seconds: 5),
        );
  }
}

/// AI 应用管理 Provider
final aIAppManagerProvider = AsyncNotifierProvider<AIAppManager, void>(
  AIAppManager.new,
  dependencies: [aiAppRepositoryProvider, appDatabaseProvider],
);
