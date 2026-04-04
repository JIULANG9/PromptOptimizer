import '../../data/models/version_response.dart';

class VersionInfo {
  final int versionCode;
  final String versionName;
  final String downloadUrl;
  final String updateMsg;

  const VersionInfo({
    required this.versionCode,
    required this.versionName,
    required this.downloadUrl,
    required this.updateMsg,
  });

  factory VersionInfo.fromResponse(PromptOptimizerVersion response) {
    return VersionInfo(
      versionCode: response.versionCode,
      versionName: response.versionName,
      downloadUrl: response.downloadUrl,
      updateMsg: response.updateMsg,
    );
  }
}
