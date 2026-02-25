import 'package:drift/drift.dart' as drift;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../database/app_database.dart' as db;

part 'ai_app_config.freezed.dart';
part 'ai_app_config.g.dart';

/// AI 应用配置数据模型
@freezed
class AIAppConfigModel with _$AIAppConfigModel {
  const factory AIAppConfigModel({
    required String id,
    required String name,
    required String scheme,
    required String iconPath,
    @Default(true) bool isEnabled,
    @Default(0) int position,
    @Default(false) bool isBuiltin,
    required DateTime createdAt,
  }) = _AIAppConfigModel;

  const AIAppConfigModel._();

  /// 从 JSON 反序列化
  factory AIAppConfigModel.fromJson(Map<String, dynamic> json) =>
      _$AIAppConfigModelFromJson(json);

  /// 从 Drift 数据库模型转换
  factory AIAppConfigModel.fromDrift(db.AIAppConfig data) {
    return AIAppConfigModel(
      id: data.id,
      name: data.name,
      scheme: data.scheme,
      iconPath: data.iconPath,
      isEnabled: data.isEnabled,
      position: data.position,
      isBuiltin: data.isBuiltin,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data.createdAt),
    );
  }

  /// 转换为 Drift Companion（用于数据库插入/更新）
  db.AIAppConfigsCompanion toCompanion() {
    return db.AIAppConfigsCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      scheme: drift.Value(scheme),
      iconPath: drift.Value(iconPath),
      isEnabled: drift.Value(isEnabled),
      position: drift.Value(position),
      isBuiltin: drift.Value(isBuiltin),
      createdAt: drift.Value(createdAt.millisecondsSinceEpoch),
    );
  }
}
