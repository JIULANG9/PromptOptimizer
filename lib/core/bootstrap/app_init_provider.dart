import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_bootstrapper.dart';

enum AppInitStatus {
  idle,
  loading,
  ready,
  error,
}

class AppInitState {
  final AppInitStatus status;
  final String? errorMessage;
  final AppBootstrapResult? result;

  const AppInitState({
    this.status = AppInitStatus.idle,
    this.errorMessage,
    this.result,
  });

  AppInitState copyWith({
    AppInitStatus? status,
    String? errorMessage,
    AppBootstrapResult? result,
    bool clearError = false,
  }) {
    return AppInitState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      result: result ?? this.result,
    );
  }
}

class AppInitNotifier extends Notifier<AppInitState> {
  @override
  AppInitState build() {
    final preInitFuture = ref.watch(bootstrapResultFutureProvider);
    // 异步初始化在 build 之后触发，避免在 build 内 await
    Future.microtask(() => _initialize(preInitFuture));
    return const AppInitState();
  }

  Future<void> _initialize(Future<AppBootstrapResult>? preInitFuture) async {
    state = state.copyWith(status: AppInitStatus.loading, clearError: true);
    try {
      // 如果有预初始化的 Future，直接使用，否则创建新的
      final result = preInitFuture != null
          ? await preInitFuture
          : await AppBootstrapper().bootstrap();
      state = state.copyWith(status: AppInitStatus.ready, result: result);
    } catch (e) {
      state = state.copyWith(status: AppInitStatus.error, errorMessage: e.toString());
    }
  }
}

/// 预初始化结果 Provider（由 main.dart 注入）
final bootstrapResultFutureProvider = Provider<Future<AppBootstrapResult>?>((ref) {
  return null;
});

final appInitProvider = NotifierProvider<AppInitNotifier, AppInitState>(
  AppInitNotifier.new,
);
