import 'package:package_info_plus/package_info_plus.dart';
import '../../data/repositories/version_repository.dart';
import '../entities/version_info.dart';

class VersionCheckResult {
  final bool hasUpdate;
  final VersionInfo? versionInfo;
  final String? errorMessage;

  const VersionCheckResult({
    required this.hasUpdate,
    this.versionInfo,
    this.errorMessage,
  });

  factory VersionCheckResult.hasUpdate(VersionInfo info) {
    return VersionCheckResult(hasUpdate: true, versionInfo: info);
  }

  factory VersionCheckResult.noUpdate() {
    return const VersionCheckResult(hasUpdate: false);
  }

  factory VersionCheckResult.error(String message) {
    return VersionCheckResult(hasUpdate: false, errorMessage: message);
  }
}

class CheckVersionUseCase {
  final VersionRepository _repository;

  CheckVersionUseCase(this._repository);

  Future<VersionCheckResult> execute() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.tryParse(packageInfo.buildNumber) ?? 0;

      final latestVersion = await _repository.fetchLatestVersion();
      if (latestVersion == null) {
        return VersionCheckResult.error('网络请求失败');
      }

      if (latestVersion.versionCode > currentVersionCode) {
        return VersionCheckResult.hasUpdate(
          VersionInfo.fromResponse(latestVersion),
        );
      } else {
        return VersionCheckResult.noUpdate();
      }
    } catch (e) {
      return VersionCheckResult.error(e.toString());
    }
  }
}
