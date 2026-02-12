import 'package:drift/drift.dart';

/// API 配置表
/// 存储用户配置的 AI 模型 API 信息（密钥、地址、模型ID等）
class ApiConfigs extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get apiKey => text()();
  TextColumn get baseUrl => text().withDefault(
    const Constant('https://dashscope.aliyuncs.com/compatible-mode/v1'),
  )();
  TextColumn get modelId =>
      text().withDefault(const Constant('qwen-plus-2025-12-01'))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt =>
      integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();

  @override
  Set<Column> get primaryKey => {id};
}
