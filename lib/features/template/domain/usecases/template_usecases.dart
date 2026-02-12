import '../../data/template_repository.dart';
import '../entities/template_entity.dart';

/// 模板用例 — 纯业务逻辑，无 Flutter 依赖
class TemplateUseCases {
  final TemplateRepository _repository;

  TemplateUseCases(this._repository);

  /// 获取所有模板
  Future<List<TemplateEntity>> getAll() => _repository.getAll();

  /// 监听所有模板变化
  Stream<List<TemplateEntity>> watchAll() => _repository.watchAll();

  /// 根据类型获取模板（'userOptimize' | 'systemOptimize'）
  Future<List<TemplateEntity>> getByType(String type) =>
      _repository.getByType(type);

  /// 根据 ID 获取模板
  Future<TemplateEntity?> getById(String id) => _repository.getById(id);

  /// 创建新模板
  Future<void> create(TemplateEntity entity) => _repository.create(entity);

  /// 更新模板
  Future<void> update(TemplateEntity entity) => _repository.update(entity);

  /// 删除模板（内置模板不可删除，由 Presentation 层校验）
  Future<void> delete(String id) => _repository.delete(id);
}
