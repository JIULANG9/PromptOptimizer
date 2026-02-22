import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../../history/presentation/providers/history_provider.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../../widgets/toast/toast_models.dart';
import '../../domain/entities/optimization_state.dart';
import '../providers/optimization_provider.dart';
import '../widgets/control_panel.dart';
import '../widgets/prompt_input.dart';
import '../widgets/prompt_tab_bar.dart';
import '../widgets/result_panel.dart';
import '../widgets/onboarding_bottom_sheet.dart';
import '../../../widgets/animation/delayed_entrance.dart';

/// 首页 — 应用主界面
/// 响应式布局：桌面端双栏（左输入 + 右结果），移动端单栏 + 结果页
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final _promptController = TextEditingController();

  /// 入场动画控制器
  late final AnimationController _entranceController;

  /// 相邻组件入场延迟间隔（毫秒），统一修改此值即可调整节奏
  static const int _staggerDelayMs = 200;

  /// 动画总时长（毫秒），需覆盖所有 delay + 单个动画播放时间
  static const int _totalDurationMs = 800;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _totalDurationMs),
    );
    // 页面首次进入时自动触发,仅播放一次
    _entranceController.forward();
    
    // 延迟显示引导弹窗
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OnboardingBottomSheet.showIfNeeded(context);
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  /// 计算第 [index] 个组件的延迟比例（用于 Interval）
  double _delayRatio(int index) {
    return (index * _staggerDelayMs / _totalDurationMs).clamp(0.0, 0.99);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final optState = ref.watch(optimizationProvider);

    // 全局监听：优化完成后 toast 提示 + 移动端流式开始时跳转结果页
    ref.listen<OptimizationState>(optimizationProvider, (prev, next) {
      // 流式完成 → 显示成功 toast + 刷新历史列表
      if (prev?.status == OptimizationStatus.streaming &&
          next.status == OptimizationStatus.success) {
        ref
            .read(toastProvider.notifier)
            .showSuccess(l10n.toastOptimizeComplete);
        ref.read(historyListProvider.notifier).loadHistories();
      }
      // 错误 → 显示错误 toast
      if (next.status == OptimizationStatus.error &&
          prev?.status != OptimizationStatus.error) {
        ref.read(toastProvider.notifier).showError(next.errorMessage);
      }
      // 移动端：开始流式时跳转结果页
      if (prev?.status != OptimizationStatus.streaming &&
          next.status == OptimizationStatus.streaming) {
        final screenWidth = MediaQuery.of(context).size.width;
        if (screenWidth <= AppConstants.desktopBreakpoint) {
          context.push(AppRouter.result);
        }
      }
    });

    return GlassScaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        leading: IconButton(
          icon: const Icon(Icons.history_outlined),
          onPressed: () => context.push(AppRouter.historyList),
          tooltip: l10n.settingsHistory,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRouter.settings),
            tooltip: l10n.btnSettings,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop =
              constraints.maxWidth > AppConstants.desktopBreakpoint;

          if (isDesktop) {
            return _buildDesktopLayout(optState);
          } else {
            return _buildMobileLayout(optState);
          }
        },
      ),
    );
  }

  /// 桌面端双栏布局
  Widget _buildDesktopLayout(OptimizationState optState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左栏：Tab + 控制面板 + 输入
        Expanded(
          child: Column(
            children: [
              DelayedEntrance(
                controller: _entranceController,
                delay: _delayRatio(0),
                child: PromptTabBar(
                  currentTab: optState.currentTab,
                  onTabChanged: (type) =>
                      ref.read(optimizationProvider.notifier).switchTab(type),
                ),
              ),
              DelayedEntrance(
                controller: _entranceController,
                delay: _delayRatio(1),
                child: const ControlPanel(),
              ),
              Expanded(
                child: DelayedEntrance(
                  controller: _entranceController,
                  delay: _delayRatio(2),
                  child: PromptInput(
                    controller: _promptController,
                    isProcessing: optState.isProcessing,
                    onOptimize: _onOptimize,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 右栏：结果面板
        Expanded(
          child: DelayedEntrance(
            controller: _entranceController,
            delay: _delayRatio(1),
            child: ResultPanel(
              optimizationState: optState,
              onTextChanged: (text) => ref
                  .read(optimizationProvider.notifier)
                  .updateOptimizedPrompt(text),
            ),
          ),
        ),
      ],
    );
  }

  /// 移动端单栏布局
  Widget _buildMobileLayout(OptimizationState optState) {
    return Column(
      children: [
        // 第 0 个组件：0ms 入场
        DelayedEntrance(
          controller: _entranceController,
          delay: _delayRatio(0),
          child: PromptTabBar(
            currentTab: optState.currentTab,
            onTabChanged: (type) =>
                ref.read(optimizationProvider.notifier).switchTab(type),
          ),
        ),
        // 第 1 个组件：100ms 入场
        DelayedEntrance(
          controller: _entranceController,
          delay: _delayRatio(1),
          child: const ControlPanel(),
        ),
        // 第 2 个组件：200ms 入场
        Expanded(
          child: DelayedEntrance(
            controller: _entranceController,
            delay: _delayRatio(2),
            child: PromptInput(
              controller: _promptController,
              isProcessing: optState.isProcessing,
              onOptimize: _onOptimize,
            ),
          ),
        ),
      ],
    );
  }

  void _onOptimize() {
    final l10n = AppLocalizations.of(context)!;

    // 检查是否有可用的 API 配置
    final enabledConfigs = ref
        .read(apiConfigListProvider)
        .configs
        .where((c) => c.isEnabled)
        .toList();
    if (enabledConfigs.isEmpty) {
      ref
          .read(toastProvider.notifier)
          .showAction(
            message: l10n.apiConfigNoAvailable,
            type: ToastType.normal,
            primaryAction: ToastAction(
              label: l10n.btnAddNow,
              onPressed: () {
                context.push(AppRouter.apiConfigNew);
              },
            ),
            duration: const Duration(seconds: 4),
          );
      return;
    }

    ref.read(optimizationProvider.notifier).optimize(_promptController.text);
  }
}
