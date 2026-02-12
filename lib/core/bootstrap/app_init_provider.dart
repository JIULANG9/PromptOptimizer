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

class AppInitNotifier extends StateNotifier<AppInitState> {
  final AppBootstrapper _bootstrapper;

  AppInitNotifier(this._bootstrapper) : super(const AppInitState()) {
    start();
  }

  Future<void> start() async {
    state = state.copyWith(status: AppInitStatus.loading, clearError: true);
    try {
      final result = await _bootstrapper.bootstrap();
      state = state.copyWith(status: AppInitStatus.ready, result: result);
    } catch (e) {
      state = state.copyWith(status: AppInitStatus.error, errorMessage: e.toString());
    }
  }
}

final appBootstrapperProvider = Provider<AppBootstrapper>((ref) {
  return AppBootstrapper();
});

final appInitProvider = StateNotifierProvider<AppInitNotifier, AppInitState>((ref) {
  return AppInitNotifier(ref.watch(appBootstrapperProvider));
});
