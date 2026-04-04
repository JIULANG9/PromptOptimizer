// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_dao.dart';

// ignore_for_file: type=lint
mixin _$TemplateDaoMixin on DatabaseAccessor<AppDatabase> {
  $PromptTemplatesTable get promptTemplates => attachedDatabase.promptTemplates;
  TemplateDaoManager get managers => TemplateDaoManager(this);
}

class TemplateDaoManager {
  final _$TemplateDaoMixin _db;
  TemplateDaoManager(this._db);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.promptTemplates,
      );
}
