// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_config_dao.dart';

// ignore_for_file: type=lint
mixin _$ApiConfigDaoMixin on DatabaseAccessor<AppDatabase> {
  $ApiConfigsTable get apiConfigs => attachedDatabase.apiConfigs;
  ApiConfigDaoManager get managers => ApiConfigDaoManager(this);
}

class ApiConfigDaoManager {
  final _$ApiConfigDaoMixin _db;
  ApiConfigDaoManager(this._db);
  $$ApiConfigsTableTableManager get apiConfigs =>
      $$ApiConfigsTableTableManager(_db.attachedDatabase, _db.apiConfigs);
}
