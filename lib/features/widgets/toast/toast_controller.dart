import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'toast_models.dart';
import 'toast_theme.dart';

/// Toast 控制器 Provider
final toastProvider = StateNotifierProvider<ToastController, ToastState>((ref) {
  return ToastController();
});

/// Toast 控制器
class ToastController extends StateNotifier<ToastState> {
  ToastController() : super(const ToastState());

  Timer? _timer;

  /// 显示普通消息
  void show(
    String message, {
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    _addRequest(
      ToastRequest(
        message: message,
        type: ToastType.normal,
        duration: duration,
        position: position,
        onDismissed: onDismissed,
      ),
    );
  }

  /// 显示成功消息
  void showSuccess(
    String message, {
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    _addRequest(
      ToastRequest(
        message: message,
        type: ToastType.success,
        duration: duration,
        position: position,
        onDismissed: onDismissed,
      ),
    );
  }

  /// 显示错误消息
  void showError(
    String message, {
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    _addRequest(
      ToastRequest(
        message: message,
        type: ToastType.error,
        duration: duration ?? ToastTheme.longDuration,
        position: position,
        onDismissed: onDismissed,
      ),
    );
  }

  /// 显示警告消息
  void showWarning(
    String message, {
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    _addRequest(
      ToastRequest(
        message: message,
        type: ToastType.warning,
        duration: duration,
        position: position,
        onDismissed: onDismissed,
      ),
    );
  }

  /// 显示信息消息
  void showInfo(
    String message, {
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    _addRequest(
      ToastRequest(
        message: message,
        type: ToastType.info,
        duration: duration,
        position: position,
        onDismissed: onDismissed,
      ),
    );
  }

  /// 显示带操作按钮的 Toast (Action Toast)
  void showAction({
    required String message,
    required ToastAction primaryAction,
    ToastAction? secondaryAction,
    ToastType type = ToastType.normal,
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    _addRequest(
      ToastRequest(
        message: message,
        type: type,
        duration: duration ?? ToastTheme.longDuration,
        position: position,
        primaryAction: primaryAction,
        secondaryAction: secondaryAction,
        onDismissed: onDismissed,
      ),
    );
  }

  /// 显示进度 Toast
  /// 返回 request id
  String showProgress({
    String? id,
    required String message,
    double progress = 0.0,
    ToastPosition position = ToastPosition.top,
    VoidCallback? onDismissed,
  }) {
    final requestId = id ?? DateTime.now().millisecondsSinceEpoch.toString();

    // 更新进度映射
    final newProgressMap = Map<String, double>.from(state.progressMap);
    newProgressMap[requestId] = progress;

    // 如果当前已经在显示这个 ID 的进度 Toast，直接更新状态
    if (state.current?.id == requestId &&
        state.current?.type == ToastType.progress) {
      state = state.copyWith(
        current: state.current!.copyWith(progress: progress),
        progressMap: newProgressMap,
      );
      return requestId;
    }

    // 否则作为新请求加入
    _addRequest(
      ToastRequest(
        id: requestId,
        message: message,
        type: ToastType.progress,
        progress: progress,
        position: position,
        duration: const Duration(days: 1), // 进度条默认不自动消失，直到手动 dismiss 或完成
        onDismissed: onDismissed,
      ),
    );

    // 更新进度 Map
    state = state.copyWith(progressMap: newProgressMap);

    return requestId;
  }

  /// 更新进度
  void updateProgress({required String id, required double progress}) {
    final newProgressMap = Map<String, double>.from(state.progressMap);
    newProgressMap[id] = progress;

    // 如果当前正在显示该进度 Toast，实时更新 UI
    if (state.current?.id == id && state.current?.type == ToastType.progress) {
      state = state.copyWith(
        current: state.current!.copyWith(progress: progress),
        progressMap: newProgressMap,
      );
    } else {
      state = state.copyWith(progressMap: newProgressMap);
    }
  }

  /// 关闭 Toast
  /// [id] 可选，指定关闭特定 ID 的 Toast。如果不传，则关闭当前显示的 Toast。
  void dismiss([String? id]) {
    // 如果指定了 ID，且不是当前显示的，则从队列中移除（如果存在）
    if (id != null && state.current?.id != id) {
      final newQueue = state.queue.where((req) => req.id != id).toList();
      // 清理进度 Map
      final newProgressMap = Map<String, double>.from(state.progressMap)
        ..remove(id);
      state = state.copyWith(queue: newQueue, progressMap: newProgressMap);
      return;
    }

    // 关闭当前 Toast
    _dismissCurrent();

    if (id != null) {
      final newProgressMap = Map<String, double>.from(state.progressMap)
        ..remove(id);
      state = state.copyWith(progressMap: newProgressMap);
    }
  }

  /// 内部：添加请求到队列或直接显示
  void _addRequest(ToastRequest request) {
    if (state.current == null) {
      state = state.copyWith(current: request);
      _scheduleAutoDismiss(request);
    } else {
      state = state.copyWith(queue: [...state.queue, request]);
    }
  }

  /// 内部：关闭当前并显示下一个
  void _dismissCurrent() {
    _timer?.cancel();

    // 触发回调
    state.current?.onDismissed?.call();

    if (state.queue.isNotEmpty) {
      // 队列不为空，取出下一个
      final next = state.queue.first;
      final remainingQueue = state.queue.sublist(1);

      state = state.copyWith(current: next, queue: remainingQueue);

      _scheduleAutoDismiss(next);
    } else {
      // 队列为空
      state = state.copyWith(current: null);
    }
  }

  /// 内部：安排自动关闭
  void _scheduleAutoDismiss(ToastRequest request) {
    _timer?.cancel();

    // 如果 duration 为 null，使用默认时长
    // 进度条类型默认给了一个很长的 duration，通常由业务逻辑手动关闭
    final duration = request.duration ?? ToastTheme.defaultDuration;

    // 只有非永久显示的才设置定时器
    if (duration != Duration.zero) {
      _timer = Timer(duration, () {
        _dismissCurrent();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
