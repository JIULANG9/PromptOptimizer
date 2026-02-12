import '../../../../core/constants/app_constants.dart';

/// 优化流程状态枚举
enum OptimizationStatus {
  /// 空闲，等待用户输入
  idle,

  /// 正在准备请求（获取配置、构建消息）
  loading,

  /// 正在接收流式响应
  streaming,

  /// 优化成功完成
  success,

  /// 发生错误
  error,
}

/// 优化流程状态（MVI 中的 Model）
/// 不可变状态对象，通过 copyWith 创建新实例
class OptimizationState {
  final OptimizationStatus status;
  final String originalPrompt;
  final String optimizedPrompt; // 累积的流式结果
  final String errorMessage;
  final String currentTab; // 'userOptimize' | 'systemOptimize'
  final String? selectedApiConfigId;
  final String? selectedTemplateId;

  final DateTime? startTime;
  final DateTime? networkResponseTime;
  final Duration currentDuration;

  const OptimizationState({
    this.status = OptimizationStatus.idle,
    this.originalPrompt = '',
    this.optimizedPrompt = '',
    this.errorMessage = '',
    this.currentTab = AppConstants.templateTypeUser,
    this.selectedApiConfigId,
    this.selectedTemplateId,
    this.startTime,
    this.networkResponseTime,
    this.currentDuration = Duration.zero,
  });

  /// 是否正在处理中（loading 或 streaming）
  bool get isProcessing =>
      status == OptimizationStatus.loading ||
      status == OptimizationStatus.streaming;

  /// 是否有结果可展示
  bool get hasResult => optimizedPrompt.isNotEmpty;

  /// 创建副本并覆盖指定字段
  OptimizationState copyWith({
    OptimizationStatus? status,
    String? originalPrompt,
    String? optimizedPrompt,
    String? errorMessage,
    String? currentTab,
    String? selectedApiConfigId,
    String? selectedTemplateId,
    DateTime? startTime,
    DateTime? networkResponseTime,
    Duration? currentDuration,
    bool clearApiConfigId = false,
    bool clearTemplateId = false,
    bool clearStartTime = false,
    bool clearNetworkResponseTime = false,
  }) {
    return OptimizationState(
      status: status ?? this.status,
      originalPrompt: originalPrompt ?? this.originalPrompt,
      optimizedPrompt: optimizedPrompt ?? this.optimizedPrompt,
      errorMessage: errorMessage ?? this.errorMessage,
      currentTab: currentTab ?? this.currentTab,
      selectedApiConfigId: clearApiConfigId
          ? null
          : (selectedApiConfigId ?? this.selectedApiConfigId),
      selectedTemplateId: clearTemplateId
          ? null
          : (selectedTemplateId ?? this.selectedTemplateId),
      startTime: clearStartTime ? null : (startTime ?? this.startTime),
      networkResponseTime: clearNetworkResponseTime
          ? null
          : (networkResponseTime ?? this.networkResponseTime),
      currentDuration: currentDuration ?? this.currentDuration,
    );
  }
}
