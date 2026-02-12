import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../../history/presentation/providers/history_provider.dart';
import '../../../settings/data/settings_repository.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../../template/presentation/providers/template_provider.dart';
import '../../data/openai_api_service.dart';
import '../../domain/entities/optimization_state.dart';
import '../../domain/usecases/optimize_prompt_usecase.dart';

/// 优化流程 Notifier（MVI Intent 处理器）
/// 管理首页的完整优化状态：Tab 切换、配置选择、流式优化、结果编辑
class OptimizationNotifier extends StateNotifier<OptimizationState> {
  final OptimizePromptUseCase _useCase;
  final SettingsRepository _settingsRepo;
  StreamSubscription<String>? _streamSubscription;
  Timer? _timer;

  OptimizationNotifier(this._useCase, this._settingsRepo)
    : super(const OptimizationState()) {
    _loadPersistedSelections();
  }

  /// 从 Hive 恢复上次的选择
  void _loadPersistedSelections() {
    final apiConfigId = _settingsRepo.getSelectedApiConfigId();
    final currentTab = state.currentTab;
    final templateId = _settingsRepo.getSelectedTemplateId(currentTab);
    state = state.copyWith(
      selectedApiConfigId: apiConfigId,
      selectedTemplateId: templateId,
    );
  }

  /// Intent: 切换 Tab（用户提示词 / 系统提示词）
  void switchTab(String type) {
    // 切换 Tab 时恢复该 Tab 对应的模板选择
    final templateId = _settingsRepo.getSelectedTemplateId(type);
    state = state.copyWith(currentTab: type, clearTemplateId: true);
    if (templateId != null) {
      state = state.copyWith(selectedTemplateId: templateId);
    }
  }

  /// Intent: 选择 API 配置
  void selectApiConfig(String id) {
    state = state.copyWith(selectedApiConfigId: id);
    _settingsRepo.saveSelectedApiConfigId(id);
  }

  /// Intent: 选择模板
  void selectTemplate(String id) {
    state = state.copyWith(selectedTemplateId: id);
    _settingsRepo.saveSelectedTemplateId(state.currentTab, id);
  }

  /// Intent: 执行优化
  Future<void> optimize(String originalPrompt) async {
    if (originalPrompt.trim().isEmpty) {
      state = state.copyWith(
        status: OptimizationStatus.error,
        errorMessage: 'Prompt is empty',
      );
      return;
    }

    if (state.selectedApiConfigId == null) {
      state = state.copyWith(
        status: OptimizationStatus.error,
        errorMessage: 'No API config selected',
      );
      return;
    }

    if (state.selectedTemplateId == null) {
      state = state.copyWith(
        status: OptimizationStatus.error,
        errorMessage: 'No template selected',
      );
      return;
    }

    // 取消之前的流
    await cancelOptimization();

    _startTimer();
    state = state.copyWith(
      status: OptimizationStatus.loading,
      originalPrompt: originalPrompt,
      optimizedPrompt: '',
      errorMessage: '',
      startTime: DateTime.now(),
      clearNetworkResponseTime: true,
      currentDuration: Duration.zero,
    );

    try {
      final stream = _useCase.execute(
        originalPrompt: originalPrompt,
        apiConfigId: state.selectedApiConfigId!,
        templateId: state.selectedTemplateId!,
        type: state.currentTab,
      );

      state = state.copyWith(status: OptimizationStatus.streaming);

      _streamSubscription = stream.listen(
        (chunk) {
          final now = DateTime.now();
          // 仅在第一次收到数据时记录网络响应时间
          if (state.networkResponseTime == null) {
            state = state.copyWith(networkResponseTime: now);
          }

          // 累积流式内容
          state = state.copyWith(
            optimizedPrompt: state.optimizedPrompt + chunk,
          );
        },
        onError: (Object error) {
          _stopTimer();
          state = state.copyWith(
            status: OptimizationStatus.error,
            errorMessage: error.toString(),
          );
        },
        onDone: () async {
          _stopTimer();
          // 先捕获当前累积的完整结果，再更新状态
          final completedPrompt = state.optimizedPrompt;
          final originalText = state.originalPrompt;
          final tab = state.currentTab;
          final apiId = state.selectedApiConfigId!;
          final tplId = state.selectedTemplateId!;

          state = state.copyWith(status: OptimizationStatus.success);

          // 自动保存历史
          try {
            await _useCase.saveHistory(
              originalPrompt: originalText,
              optimizedPrompt: completedPrompt,
              type: tab,
              modelKey: apiId,
              templateId: tplId,
            );
          } catch (_) {
            // 历史保存失败不影响主流程
          }
        },
      );
    } catch (e) {
      _stopTimer();
      state = state.copyWith(
        status: OptimizationStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Intent: 取消优化
  Future<void> cancelOptimization() async {
    _stopTimer();
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    if (state.isProcessing) {
      state = state.copyWith(status: OptimizationStatus.idle);
    }
  }

  /// Intent: 手动编辑优化结果
  void updateOptimizedPrompt(String text) {
    state = state.copyWith(optimizedPrompt: text);
  }

  /// Intent: 清空结果
  void clearResult() {
    state = state.copyWith(
      status: OptimizationStatus.idle,
      optimizedPrompt: '',
      errorMessage: '',
      clearStartTime: true,
      clearNetworkResponseTime: true,
      currentDuration: Duration.zero,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (state.startTime != null) {
        final duration = DateTime.now().difference(state.startTime!);
        state = state.copyWith(currentDuration: duration);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}

// ─── Providers ───

/// Dio 实例 Provider
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

/// OpenAI API 服务 Provider
final openAiApiServiceProvider = Provider<OpenAiApiService>((ref) {
  return OpenAiApiService(ref.watch(dioProvider));
});

/// 优化用例 Provider
final optimizePromptUseCaseProvider = Provider<OptimizePromptUseCase>((ref) {
  return OptimizePromptUseCase(
    apiService: ref.watch(openAiApiServiceProvider),
    apiConfigRepo: ref.watch(apiConfigRepositoryProvider),
    templateRepo: ref.watch(templateRepositoryProvider),
    historyRepo: ref.watch(historyRepositoryProvider),
  );
});

/// 优化状态 Provider
final optimizationProvider =
    StateNotifierProvider<OptimizationNotifier, OptimizationState>((ref) {
      return OptimizationNotifier(
        ref.watch(optimizePromptUseCaseProvider),
        ref.watch(settingsRepositoryProvider),
      );
    });
