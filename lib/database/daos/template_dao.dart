import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/prompt_templates_table.dart';

part 'template_dao.g.dart';

/// 模板数据访问对象
/// 封装 PromptTemplates 表的所有数据库操作
@DriftAccessor(tables: [PromptTemplates])
class TemplateDao extends DatabaseAccessor<AppDatabase>
    with _$TemplateDaoMixin {
  TemplateDao(super.db);

  /// 获取所有模板
  Future<List<PromptTemplate>> getAllTemplates() =>
      select(promptTemplates).get();

  /// 监听所有模板变化
  Stream<List<PromptTemplate>> watchAllTemplates() =>
      select(promptTemplates).watch();

  /// 根据类型获取模板
  Future<List<PromptTemplate>> getTemplatesByType(String type) => (select(
    promptTemplates,
  )..where((t) => t.templateType.equals(type))).get();

  /// 根据 ID 获取模板
  Future<PromptTemplate?> getTemplateById(String id) async {
    final results = await (select(
      promptTemplates,
    )..where((t) => t.id.equals(id))).get();
    return results.isEmpty ? null : results.first;
  }

  /// 插入模板
  Future<void> insertTemplate(PromptTemplatesCompanion template) =>
      into(promptTemplates).insert(template);

  /// 更新模板
  Future<bool> updateTemplate(PromptTemplatesCompanion template) =>
      (update(promptTemplates)..where((t) => t.id.equals(template.id.value)))
          .write(template)
          .then((rows) => rows > 0);

  /// 删除模板
  Future<int> deleteTemplate(String id) =>
      (delete(promptTemplates)..where((t) => t.id.equals(id))).go();
}
