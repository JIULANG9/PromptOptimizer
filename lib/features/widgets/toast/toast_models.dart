import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toast_models.freezed.dart';

/// Toast 类型
enum ToastType { normal, success, info, warning, error, progress }

/// Toast 显示位置
enum ToastPosition { top, bottom }

/// Toast 操作按钮
@freezed
class ToastAction with _$ToastAction {
  const factory ToastAction({
    required String label,
    required VoidCallback onPressed,
  }) = _ToastAction;
}

/// Toast 请求数据
@freezed
class ToastRequest with _$ToastRequest {
  const factory ToastRequest({
    /// 唯一标识，用于进度更新或手动移除
    String? id,

    /// Toast 类型
    @Default(ToastType.normal) ToastType type,

    /// 显示消息
    required String message,

    /// 显示时长，null 则使用默认时长
    Duration? duration,

    /// 自定义图标
    Widget? icon,

    /// 进度值 (0.0 - 1.0), 仅 type == progress 有效
    double? progress,

    /// 显示位置
    @Default(ToastPosition.top) ToastPosition position,

    /// 主操作按钮
    ToastAction? primaryAction,

    /// 次要操作按钮
    ToastAction? secondaryAction,

    /// 消失时的回调
    VoidCallback? onDismissed,
  }) = _ToastRequest;
}

/// Toast 状态
@freezed
class ToastState with _$ToastState {
  const factory ToastState({
    /// 当前显示的 Toast
    ToastRequest? current,

    /// 等待队列
    @Default([]) List<ToastRequest> queue,

    /// 进度任务状态映射 (id -> progress)
    @Default({}) Map<String, double> progressMap,
  }) = _ToastState;
}
