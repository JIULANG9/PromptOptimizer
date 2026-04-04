// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VersionResponse _$VersionResponseFromJson(Map<String, dynamic> json) =>
    _VersionResponse(
      promptOptimizer: PromptOptimizerVersion.fromJson(
        json['PromptOptimizer'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$VersionResponseToJson(_VersionResponse instance) =>
    <String, dynamic>{'PromptOptimizer': instance.promptOptimizer};

_PromptOptimizerVersion _$PromptOptimizerVersionFromJson(
  Map<String, dynamic> json,
) => _PromptOptimizerVersion(
  versionCode: (json['versionCode'] as num).toInt(),
  versionName: json['versionName'] as String,
  downloadUrl: json['downloadUrl'] as String,
  updateMsg: json['updateMsg'] as String,
);

Map<String, dynamic> _$PromptOptimizerVersionToJson(
  _PromptOptimizerVersion instance,
) => <String, dynamic>{
  'versionCode': instance.versionCode,
  'versionName': instance.versionName,
  'downloadUrl': instance.downloadUrl,
  'updateMsg': instance.updateMsg,
};
