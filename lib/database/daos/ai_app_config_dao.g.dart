// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_app_config_dao.dart';

// ignore_for_file: type=lint
mixin _$AIAppConfigDaoMixin on DatabaseAccessor<AppDatabase> {
  $AIAppConfigsTable get aIAppConfigs => attachedDatabase.aIAppConfigs;
  AIAppConfigDaoManager get managers => AIAppConfigDaoManager(this);
}

class AIAppConfigDaoManager {
  final _$AIAppConfigDaoMixin _db;
  AIAppConfigDaoManager(this._db);
  $$AIAppConfigsTableTableManager get aIAppConfigs =>
      $$AIAppConfigsTableTableManager(_db.attachedDatabase, _db.aIAppConfigs);
}
