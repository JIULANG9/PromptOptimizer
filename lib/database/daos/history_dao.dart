import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/optimization_histories_table.dart';

part 'history_dao.g.dart';

/// 历史记录数据访问对象
/// 封装 OptimizationHistories 表的所有数据库操作
@DriftAccessor(tables: [OptimizationHistories])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  /// 获取所有历史记录（按时间倒序）
  Future<List<OptimizationHistory>> getAllHistories() =>
      (select(optimizationHistories)..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
          ]))
          .get();

  /// 监听所有历史记录变化（按时间倒序）
  Stream<List<OptimizationHistory>> watchAllHistories() =>
      (select(optimizationHistories)..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
          ]))
          .watch();

  /// 根据 ID 获取历史记录
  Future<OptimizationHistory?> getHistoryById(String id) async {
    final results = await (select(
      optimizationHistories,
    )..where((t) => t.id.equals(id))).get();
    return results.isEmpty ? null : results.first;
  }

  /// 插入历史记录
  Future<void> insertHistory(OptimizationHistoriesCompanion history) =>
      into(optimizationHistories).insert(history);

  /// 更新历史记录
  Future<bool> updateHistory(OptimizationHistoriesCompanion history) =>
      (update(optimizationHistories)
            ..where((t) => t.id.equals(history.id.value)))
          .write(history)
          .then((rows) => rows > 0);

  /// 删除历史记录
  Future<int> deleteHistory(String id) =>
      (delete(optimizationHistories)..where((t) => t.id.equals(id))).go();

  /// 清空所有历史记录
  Future<int> deleteAllHistories() => delete(optimizationHistories).go();
}
