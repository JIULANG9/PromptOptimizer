import 'package:drift/drift.dart';

/// 提示词模板表
/// 存储用户和系统内置的提示词优化模板
class PromptTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get content => text()(); // JSON 数组 [{role, content}]
  TextColumn get templateType => text()(); // 'userOptimize' | 'systemOptimize'
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get author => text().withDefault(const Constant('User'))();
  TextColumn get version => text().withDefault(const Constant('1.0.0'))();
  BoolColumn get isBuiltin => boolean().withDefault(const Constant(false))();
  IntColumn get lastModified => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
