import 'package:drift/drift.dart';

/// AI 应用配置表
/// 存储第三方 AI 应用的跳转配置（名称、URL Scheme、图标路径等）
class AIAppConfigs extends Table {
  /// 主键 (UUID)
  TextColumn get id => text()();

  /// 应用名称（如"豆包"、"通义千问"）
  TextColumn get name => text()();

  /// URL Scheme（如"doubao://"、"tongyi://"）
  TextColumn get scheme => text()();

  /// 图标路径（如"assets/icon/icon_doubao.svg"）
  TextColumn get iconPath => text()();

  /// 是否启用（默认 true）
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// 排序位置（用于控制显示顺序，默认 0）
  IntColumn get position => integer().withDefault(const Constant(0))();

  /// 是否内置应用（内置应用使用硬编码 scheme，默认 false）
  BoolColumn get isBuiltin => boolean().withDefault(const Constant(false))();

  /// 创建时间戳
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();

  @override
  Set<Column> get primaryKey => {id};
}
