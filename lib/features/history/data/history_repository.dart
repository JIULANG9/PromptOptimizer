import 'package:drift/drift.dart';

import '../../../database/app_database.dart';
import '../../../database/daos/history_dao.dart';
import '../domain/entities/history_entity.dart';

/// 历史记录仓库 — 封装 DAO 操作
/// 领域层通过此仓库进行 CRUD，不直接访问数据库
class HistoryRepository {
  final HistoryDao _dao;

  HistoryRepository(this._dao);

  /// 获取所有历史记录（按时间倒序）
  Future<List<HistoryEntity>> getAll() async {
    final histories = await _dao.getAllHistories();
    return histories.map(HistoryEntity.fromDrift).toList();
  }

  /// 监听所有历史记录变化（按时间倒序）
  Stream<List<HistoryEntity>> watchAll() {
    return _dao.watchAllHistories().map(
      (histories) => histories.map(HistoryEntity.fromDrift).toList(),
    );
  }

  /// 根据 ID 获取历史记录
  Future<HistoryEntity?> getById(String id) async {
    final history = await _dao.getHistoryById(id);
    return history != null ? HistoryEntity.fromDrift(history) : null;
  }

  /// 创建历史记录
  Future<void> create(HistoryEntity entity) async {
    await _dao.insertHistory(
      OptimizationHistoriesCompanion.insert(
        id: entity.id,
        originalPrompt: entity.originalPrompt,
        optimizedPrompt: entity.optimizedPrompt,
        type: entity.type,
        modelKey: entity.modelKey,
        templateId: entity.templateId,
        timestamp: entity.timestamp,
        metadata: Value(entity.metadata),
      ),
    );
  }

  /// 更新历史记录
  Future<void> update(HistoryEntity entity) async {
    await _dao.updateHistory(
      OptimizationHistoriesCompanion(
        id: Value(entity.id),
        originalPrompt: Value(entity.originalPrompt),
        optimizedPrompt: Value(entity.optimizedPrompt),
        type: Value(entity.type),
        modelKey: Value(entity.modelKey),
        templateId: Value(entity.templateId),
        timestamp: Value(entity.timestamp),
        metadata: Value(entity.metadata),
      ),
    );
  }

  /// 删除单条历史记录
  Future<void> delete(String id) async {
    await _dao.deleteHistory(id);
  }

  /// 清空所有历史记录
  Future<void> deleteAll() async {
    await _dao.deleteAllHistories();
  }
}
