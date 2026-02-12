import '../../data/history_repository.dart';
import '../entities/history_entity.dart';

/// 历史记录用例 — 纯业务逻辑，无 Flutter 依赖
class HistoryUseCases {
  final HistoryRepository _repository;

  HistoryUseCases(this._repository);

  /// 获取所有历史记录（按时间倒序）
  Future<List<HistoryEntity>> getAll() => _repository.getAll();

  /// 监听所有历史记录变化
  Stream<List<HistoryEntity>> watchAll() => _repository.watchAll();

  /// 根据 ID 获取历史记录
  Future<HistoryEntity?> getById(String id) => _repository.getById(id);

  /// 创建历史记录（优化完成后自动调用）
  Future<void> create(HistoryEntity entity) => _repository.create(entity);

  /// 更新历史记录（编辑优化结果后保存）
  Future<void> update(HistoryEntity entity) => _repository.update(entity);

  /// 删除单条历史记录
  Future<void> delete(String id) => _repository.delete(id);

  /// 清空所有历史记录
  Future<void> deleteAll() => _repository.deleteAll();
}
