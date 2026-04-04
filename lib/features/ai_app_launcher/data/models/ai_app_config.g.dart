// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AIAppConfigModel _$AIAppConfigModelFromJson(Map<String, dynamic> json) =>
    _AIAppConfigModel(
      id: json['id'] as String,
      name: json['name'] as String,
      scheme: json['scheme'] as String,
      iconPath: json['iconPath'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      position: (json['position'] as num?)?.toInt() ?? 0,
      isBuiltin: json['isBuiltin'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AIAppConfigModelToJson(_AIAppConfigModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'scheme': instance.scheme,
      'iconPath': instance.iconPath,
      'isEnabled': instance.isEnabled,
      'position': instance.position,
      'isBuiltin': instance.isBuiltin,
      'createdAt': instance.createdAt.toIso8601String(),
    };
