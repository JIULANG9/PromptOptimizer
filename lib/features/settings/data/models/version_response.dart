import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_response.freezed.dart';
part 'version_response.g.dart';

@freezed
abstract class VersionResponse with _$VersionResponse {
  const factory VersionResponse({
    @JsonKey(name: 'PromptOptimizer')
    required PromptOptimizerVersion promptOptimizer,
  }) = _VersionResponse;

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      _$VersionResponseFromJson(json);
}

@freezed
abstract class PromptOptimizerVersion with _$PromptOptimizerVersion {
  const factory PromptOptimizerVersion({
    required int versionCode,
    required String versionName,
    required String downloadUrl,
    required String updateMsg,
  }) = _PromptOptimizerVersion;

  factory PromptOptimizerVersion.fromJson(Map<String, dynamic> json) =>
      _$PromptOptimizerVersionFromJson(json);
}
