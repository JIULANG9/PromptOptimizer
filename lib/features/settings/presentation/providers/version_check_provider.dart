import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../optimization/presentation/providers/optimization_provider.dart';
import '../../data/repositories/version_repository.dart';
import '../../domain/entities/version_info.dart';
import '../../domain/usecases/check_version_usecase.dart';

enum VersionCheckTrigger { auto, manual }

enum VersionCheckStatus { idle, loading, hasUpdate, noUpdate, error }

class VersionCheckState {
  final VersionCheckStatus status;
  final VersionInfo? versionInfo;
  final String errorMessage;
  final bool isIgnored;
  final VersionCheckTrigger? triggeredBy;

  const VersionCheckState({
    this.status = VersionCheckStatus.idle,
    this.versionInfo,
    this.errorMessage = '',
    this.isIgnored = false,
    this.triggeredBy,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VersionCheckState &&
        other.status == status &&
        other.versionInfo == versionInfo &&
        other.errorMessage == errorMessage &&
        other.isIgnored == isIgnored &&
        other.triggeredBy == triggeredBy;
  }

  @override
  int get hashCode => Object.hash(status, versionInfo, errorMessage, isIgnored, triggeredBy);

  VersionCheckState copyWith({
    VersionCheckStatus? status,
    VersionInfo? versionInfo,
    String? errorMessage,
    bool? isIgnored,
    VersionCheckTrigger? triggeredBy,
    bool clearVersionInfo = false,
    bool clearTriggeredBy = false,
  }) {
    return VersionCheckState(
      status: status ?? this.status,
      versionInfo: clearVersionInfo ? null : (versionInfo ?? this.versionInfo),
      errorMessage: errorMessage ?? this.errorMessage,
      isIgnored: isIgnored ?? this.isIgnored,
      triggeredBy: clearTriggeredBy ? null : (triggeredBy ?? this.triggeredBy),
    );
  }
}

class VersionCheckNotifier extends Notifier<VersionCheckState> {
  late CheckVersionUseCase _useCase;
  late Box _box;

  @override
  VersionCheckState build() {
    _useCase = ref.watch(checkVersionUseCaseProvider);
    _box = Hive.box(AppConstants.versionUpdateBoxName);
    
    final isIgnored = _isInIgnorePeriod();
    return VersionCheckState(isIgnored: isIgnored);
  }

  Future<void> checkVersion({
    bool forceCheck = false,
    VersionCheckTrigger triggeredBy = VersionCheckTrigger.auto,
  }) async {
    state = state.copyWith(
      status: VersionCheckStatus.loading,
      triggeredBy: triggeredBy,
    );

    final result = await _useCase.execute();

    if (result.hasUpdate && result.versionInfo != null) {
      // 检查该版本是否在忽略期内
      if (!forceCheck && _isVersionIgnored(result.versionInfo!.versionCode)) {
        state = state.copyWith(
          status: VersionCheckStatus.idle,
          isIgnored: true,
        );
        return;
      }

      state = state.copyWith(
        status: VersionCheckStatus.hasUpdate,
        versionInfo: result.versionInfo,
        isIgnored: false,
        triggeredBy: triggeredBy,
      );
    } else if (result.errorMessage != null) {
      state = state.copyWith(
        status: VersionCheckStatus.error,
        errorMessage: result.errorMessage!,
      );
    } else {
      state = state.copyWith(
        status: VersionCheckStatus.noUpdate,
        clearVersionInfo: true,
      );
    }
  }

  void reset() {
    state = const VersionCheckState();
  }

  void ignoreUpdate() {
    if (state.versionInfo == null) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final versionCode = state.versionInfo!.versionCode;

    _box.put(AppConstants.updateIgnoreTimestampKey, now);
    _box.put(AppConstants.updateIgnoredVersionKey, versionCode);

    state = state.copyWith(
      isIgnored: true,
      status: VersionCheckStatus.idle,
      triggeredBy: VersionCheckTrigger.manual,
    );
  }

  bool _isVersionIgnored(int versionCode) {
    final ignoreTimestamp = _box.get(AppConstants.updateIgnoreTimestampKey) as int?;
    final ignoredVersion = _box.get(AppConstants.updateIgnoredVersionKey) as int?;

    if (ignoreTimestamp == null || ignoredVersion == null) return false;

    // 如果版本号不同，说明是新版本，不忽略
    if (ignoredVersion != versionCode) return false;

    // 版本号相同，检查是否在忽略期内
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - ignoreTimestamp;
    return elapsed < AppConstants.updateIgnoreDuration;
  }

  bool _isInIgnorePeriod() {
    final ignoreTimestamp = _box.get(AppConstants.updateIgnoreTimestampKey) as int?;
    final ignoredVersion = _box.get(AppConstants.updateIgnoredVersionKey) as int?;

    if (ignoreTimestamp == null || ignoredVersion == null) return false;

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - ignoreTimestamp;
    return elapsed < AppConstants.updateIgnoreDuration;
  }

  /// 获取当前忽略的更新信息，返回 (versionCode, remainingDays)
  /// 如果没有正在忽略的更新，返回 null
  (int versionCode, int remainingDays)? getIgnoredUpdateInfo() {
    final ignoreTimestamp = _box.get(AppConstants.updateIgnoreTimestampKey) as int?;
    final ignoredVersion = _box.get(AppConstants.updateIgnoredVersionKey) as int?;

    if (ignoreTimestamp == null || ignoredVersion == null) return null;

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - ignoreTimestamp;

    if (elapsed >= AppConstants.updateIgnoreDuration) return null;

    final remainingMs = AppConstants.updateIgnoreDuration - elapsed;
    final remainingDays = (remainingMs / (24 * 60 * 60 * 1000)).ceil();

    return (ignoredVersion, remainingDays);
  }
}

final versionRepositoryProvider = Provider<VersionRepository>((ref) {
  return VersionRepository(ref.watch(dioProvider));
});

final checkVersionUseCaseProvider = Provider<CheckVersionUseCase>((ref) {
  return CheckVersionUseCase(ref.watch(versionRepositoryProvider));
});

final versionCheckProvider =
    NotifierProvider<VersionCheckNotifier, VersionCheckState>(
  VersionCheckNotifier.new,
);
