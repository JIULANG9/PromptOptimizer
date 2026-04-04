// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_dao.dart';

// ignore_for_file: type=lint
mixin _$HistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $OptimizationHistoriesTable get optimizationHistories =>
      attachedDatabase.optimizationHistories;
  HistoryDaoManager get managers => HistoryDaoManager(this);
}

class HistoryDaoManager {
  final _$HistoryDaoMixin _db;
  HistoryDaoManager(this._db);
  $$OptimizationHistoriesTableTableManager get optimizationHistories =>
      $$OptimizationHistoriesTableTableManager(
        _db.attachedDatabase,
        _db.optimizationHistories,
      );
}
