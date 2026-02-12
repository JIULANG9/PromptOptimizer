import 'package:drift/drift.dart';

/// 优化历史记录表
/// 存储每次提示词优化的输入、输出及元信息
class OptimizationHistories extends Table {
  TextColumn get id => text()();
  TextColumn get originalPrompt => text()();
  TextColumn get optimizedPrompt => text()();
  TextColumn get type => text()(); // 'userOptimize' | 'systemOptimize'
  TextColumn get modelKey => text()(); // 关联 api_config.id
  TextColumn get templateId => text()(); // 关联 template.id
  IntColumn get timestamp => integer()();
  TextColumn get metadata =>
      text().withDefault(const Constant('{}'))(); // JSON 扩展字段

  @override
  Set<Column> get primaryKey => {id};
}
