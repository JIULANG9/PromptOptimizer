import 'package:drift/drift.dart';

import '../../../database/app_database.dart';
import '../../../database/daos/template_dao.dart';
import '../domain/entities/template_entity.dart';

/// 模板仓库 — 封装 DAO 操作
/// 领域层通过此仓库进行 CRUD，不直接访问数据库
class TemplateRepository {
  final TemplateDao _dao;

  TemplateRepository(this._dao);

  /// 获取所有模板
  Future<List<TemplateEntity>> getAll() async {
    final templates = await _dao.getAllTemplates();
    return templates.map(TemplateEntity.fromDrift).toList();
  }

  /// 监听所有模板变化
  Stream<List<TemplateEntity>> watchAll() {
    return _dao.watchAllTemplates().map(
      (templates) => templates.map(TemplateEntity.fromDrift).toList(),
    );
  }

  /// 根据类型获取模板
  Future<List<TemplateEntity>> getByType(String type) async {
    final templates = await _dao.getTemplatesByType(type);
    return templates.map(TemplateEntity.fromDrift).toList();
  }

  /// 根据 ID 获取模板
  Future<TemplateEntity?> getById(String id) async {
    final template = await _dao.getTemplateById(id);
    return template != null ? TemplateEntity.fromDrift(template) : null;
  }

  /// 创建新模板
  Future<void> create(TemplateEntity entity) async {
    await _dao.insertTemplate(
      PromptTemplatesCompanion.insert(
        id: entity.id,
        name: entity.name,
        content: entity.content,
        templateType: entity.templateType,
        description: Value(entity.description),
        author: Value(entity.author),
        version: Value(entity.version),
        isBuiltin: Value(entity.isBuiltin),
        lastModified: entity.lastModified,
        createdAt: entity.createdAt,
      ),
    );
  }

  /// 更新模板
  Future<void> update(TemplateEntity entity) async {
    await _dao.updateTemplate(
      PromptTemplatesCompanion(
        id: Value(entity.id),
        name: Value(entity.name),
        content: Value(entity.content),
        templateType: Value(entity.templateType),
        description: Value(entity.description),
        author: Value(entity.author),
        version: Value(entity.version),
        lastModified: Value(entity.lastModified),
      ),
    );
  }

  /// 删除模板
  Future<void> delete(String id) async {
    await _dao.deleteTemplate(id);
  }
}
