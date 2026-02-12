// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ApiConfigsTable extends ApiConfigs
    with TableInfo<$ApiConfigsTable, ApiConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apiKeyMeta = const VerificationMeta('apiKey');
  @override
  late final GeneratedColumn<String> apiKey = GeneratedColumn<String>(
    'api_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(
      'https://dashscope.aliyuncs.com/compatible-mode/v1',
    ),
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
    'model_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('qwen-plus-2025-12-01'),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now().millisecondsSinceEpoch),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    apiKey,
    baseUrl,
    modelId,
    isEnabled,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'api_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApiConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('api_key')) {
      context.handle(
        _apiKeyMeta,
        apiKey.isAcceptableOrUnknown(data['api_key']!, _apiKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_apiKeyMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApiConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApiConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      apiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_key'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_id'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ApiConfigsTable createAlias(String alias) {
    return $ApiConfigsTable(attachedDatabase, alias);
  }
}

class ApiConfig extends DataClass implements Insertable<ApiConfig> {
  final String id;
  final String name;
  final String apiKey;
  final String baseUrl;
  final String modelId;
  final bool isEnabled;
  final int createdAt;
  const ApiConfig({
    required this.id,
    required this.name,
    required this.apiKey,
    required this.baseUrl,
    required this.modelId,
    required this.isEnabled,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['api_key'] = Variable<String>(apiKey);
    map['base_url'] = Variable<String>(baseUrl);
    map['model_id'] = Variable<String>(modelId);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  ApiConfigsCompanion toCompanion(bool nullToAbsent) {
    return ApiConfigsCompanion(
      id: Value(id),
      name: Value(name),
      apiKey: Value(apiKey),
      baseUrl: Value(baseUrl),
      modelId: Value(modelId),
      isEnabled: Value(isEnabled),
      createdAt: Value(createdAt),
    );
  }

  factory ApiConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApiConfig(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      apiKey: serializer.fromJson<String>(json['apiKey']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      modelId: serializer.fromJson<String>(json['modelId']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'apiKey': serializer.toJson<String>(apiKey),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'modelId': serializer.toJson<String>(modelId),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  ApiConfig copyWith({
    String? id,
    String? name,
    String? apiKey,
    String? baseUrl,
    String? modelId,
    bool? isEnabled,
    int? createdAt,
  }) => ApiConfig(
    id: id ?? this.id,
    name: name ?? this.name,
    apiKey: apiKey ?? this.apiKey,
    baseUrl: baseUrl ?? this.baseUrl,
    modelId: modelId ?? this.modelId,
    isEnabled: isEnabled ?? this.isEnabled,
    createdAt: createdAt ?? this.createdAt,
  );
  ApiConfig copyWithCompanion(ApiConfigsCompanion data) {
    return ApiConfig(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      apiKey: data.apiKey.present ? data.apiKey.value : this.apiKey,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApiConfig(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('apiKey: $apiKey, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('modelId: $modelId, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, apiKey, baseUrl, modelId, isEnabled, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApiConfig &&
          other.id == this.id &&
          other.name == this.name &&
          other.apiKey == this.apiKey &&
          other.baseUrl == this.baseUrl &&
          other.modelId == this.modelId &&
          other.isEnabled == this.isEnabled &&
          other.createdAt == this.createdAt);
}

class ApiConfigsCompanion extends UpdateCompanion<ApiConfig> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> apiKey;
  final Value<String> baseUrl;
  final Value<String> modelId;
  final Value<bool> isEnabled;
  final Value<int> createdAt;
  final Value<int> rowid;
  const ApiConfigsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.apiKey = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.modelId = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApiConfigsCompanion.insert({
    required String id,
    required String name,
    required String apiKey,
    this.baseUrl = const Value.absent(),
    this.modelId = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       apiKey = Value(apiKey);
  static Insertable<ApiConfig> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? apiKey,
    Expression<String>? baseUrl,
    Expression<String>? modelId,
    Expression<bool>? isEnabled,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (apiKey != null) 'api_key': apiKey,
      if (baseUrl != null) 'base_url': baseUrl,
      if (modelId != null) 'model_id': modelId,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApiConfigsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? apiKey,
    Value<String>? baseUrl,
    Value<String>? modelId,
    Value<bool>? isEnabled,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return ApiConfigsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      apiKey: apiKey ?? this.apiKey,
      baseUrl: baseUrl ?? this.baseUrl,
      modelId: modelId ?? this.modelId,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (apiKey.present) {
      map['api_key'] = Variable<String>(apiKey.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiConfigsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('apiKey: $apiKey, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('modelId: $modelId, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromptTemplatesTable extends PromptTemplates
    with TableInfo<$PromptTemplatesTable, PromptTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateTypeMeta = const VerificationMeta(
    'templateType',
  );
  @override
  late final GeneratedColumn<String> templateType = GeneratedColumn<String>(
    'template_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('User'),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1.0.0'),
  );
  static const VerificationMeta _isBuiltinMeta = const VerificationMeta(
    'isBuiltin',
  );
  @override
  late final GeneratedColumn<bool> isBuiltin = GeneratedColumn<bool>(
    'is_builtin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_builtin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<int> lastModified = GeneratedColumn<int>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    content,
    templateType,
    description,
    author,
    version,
    isBuiltin,
    lastModified,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prompt_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<PromptTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('template_type')) {
      context.handle(
        _templateTypeMeta,
        templateType.isAcceptableOrUnknown(
          data['template_type']!,
          _templateTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('is_builtin')) {
      context.handle(
        _isBuiltinMeta,
        isBuiltin.isAcceptableOrUnknown(data['is_builtin']!, _isBuiltinMeta),
      );
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PromptTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PromptTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      templateType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      isBuiltin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_builtin'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_modified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PromptTemplatesTable createAlias(String alias) {
    return $PromptTemplatesTable(attachedDatabase, alias);
  }
}

class PromptTemplate extends DataClass implements Insertable<PromptTemplate> {
  final String id;
  final String name;
  final String content;
  final String templateType;
  final String description;
  final String author;
  final String version;
  final bool isBuiltin;
  final int lastModified;
  final int createdAt;
  const PromptTemplate({
    required this.id,
    required this.name,
    required this.content,
    required this.templateType,
    required this.description,
    required this.author,
    required this.version,
    required this.isBuiltin,
    required this.lastModified,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['content'] = Variable<String>(content);
    map['template_type'] = Variable<String>(templateType);
    map['description'] = Variable<String>(description);
    map['author'] = Variable<String>(author);
    map['version'] = Variable<String>(version);
    map['is_builtin'] = Variable<bool>(isBuiltin);
    map['last_modified'] = Variable<int>(lastModified);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  PromptTemplatesCompanion toCompanion(bool nullToAbsent) {
    return PromptTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      content: Value(content),
      templateType: Value(templateType),
      description: Value(description),
      author: Value(author),
      version: Value(version),
      isBuiltin: Value(isBuiltin),
      lastModified: Value(lastModified),
      createdAt: Value(createdAt),
    );
  }

  factory PromptTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PromptTemplate(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String>(json['content']),
      templateType: serializer.fromJson<String>(json['templateType']),
      description: serializer.fromJson<String>(json['description']),
      author: serializer.fromJson<String>(json['author']),
      version: serializer.fromJson<String>(json['version']),
      isBuiltin: serializer.fromJson<bool>(json['isBuiltin']),
      lastModified: serializer.fromJson<int>(json['lastModified']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String>(content),
      'templateType': serializer.toJson<String>(templateType),
      'description': serializer.toJson<String>(description),
      'author': serializer.toJson<String>(author),
      'version': serializer.toJson<String>(version),
      'isBuiltin': serializer.toJson<bool>(isBuiltin),
      'lastModified': serializer.toJson<int>(lastModified),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  PromptTemplate copyWith({
    String? id,
    String? name,
    String? content,
    String? templateType,
    String? description,
    String? author,
    String? version,
    bool? isBuiltin,
    int? lastModified,
    int? createdAt,
  }) => PromptTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    content: content ?? this.content,
    templateType: templateType ?? this.templateType,
    description: description ?? this.description,
    author: author ?? this.author,
    version: version ?? this.version,
    isBuiltin: isBuiltin ?? this.isBuiltin,
    lastModified: lastModified ?? this.lastModified,
    createdAt: createdAt ?? this.createdAt,
  );
  PromptTemplate copyWithCompanion(PromptTemplatesCompanion data) {
    return PromptTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      content: data.content.present ? data.content.value : this.content,
      templateType: data.templateType.present
          ? data.templateType.value
          : this.templateType,
      description: data.description.present
          ? data.description.value
          : this.description,
      author: data.author.present ? data.author.value : this.author,
      version: data.version.present ? data.version.value : this.version,
      isBuiltin: data.isBuiltin.present ? data.isBuiltin.value : this.isBuiltin,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PromptTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('templateType: $templateType, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('version: $version, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('lastModified: $lastModified, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    content,
    templateType,
    description,
    author,
    version,
    isBuiltin,
    lastModified,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PromptTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.templateType == this.templateType &&
          other.description == this.description &&
          other.author == this.author &&
          other.version == this.version &&
          other.isBuiltin == this.isBuiltin &&
          other.lastModified == this.lastModified &&
          other.createdAt == this.createdAt);
}

class PromptTemplatesCompanion extends UpdateCompanion<PromptTemplate> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> content;
  final Value<String> templateType;
  final Value<String> description;
  final Value<String> author;
  final Value<String> version;
  final Value<bool> isBuiltin;
  final Value<int> lastModified;
  final Value<int> createdAt;
  final Value<int> rowid;
  const PromptTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.content = const Value.absent(),
    this.templateType = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.version = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromptTemplatesCompanion.insert({
    required String id,
    required String name,
    required String content,
    required String templateType,
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.version = const Value.absent(),
    this.isBuiltin = const Value.absent(),
    required int lastModified,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       content = Value(content),
       templateType = Value(templateType),
       lastModified = Value(lastModified),
       createdAt = Value(createdAt);
  static Insertable<PromptTemplate> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? content,
    Expression<String>? templateType,
    Expression<String>? description,
    Expression<String>? author,
    Expression<String>? version,
    Expression<bool>? isBuiltin,
    Expression<int>? lastModified,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (content != null) 'content': content,
      if (templateType != null) 'template_type': templateType,
      if (description != null) 'description': description,
      if (author != null) 'author': author,
      if (version != null) 'version': version,
      if (isBuiltin != null) 'is_builtin': isBuiltin,
      if (lastModified != null) 'last_modified': lastModified,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromptTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? content,
    Value<String>? templateType,
    Value<String>? description,
    Value<String>? author,
    Value<String>? version,
    Value<bool>? isBuiltin,
    Value<int>? lastModified,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return PromptTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      templateType: templateType ?? this.templateType,
      description: description ?? this.description,
      author: author ?? this.author,
      version: version ?? this.version,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      lastModified: lastModified ?? this.lastModified,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (templateType.present) {
      map['template_type'] = Variable<String>(templateType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (isBuiltin.present) {
      map['is_builtin'] = Variable<bool>(isBuiltin.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<int>(lastModified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('templateType: $templateType, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('version: $version, ')
          ..write('isBuiltin: $isBuiltin, ')
          ..write('lastModified: $lastModified, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OptimizationHistoriesTable extends OptimizationHistories
    with TableInfo<$OptimizationHistoriesTable, OptimizationHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OptimizationHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalPromptMeta = const VerificationMeta(
    'originalPrompt',
  );
  @override
  late final GeneratedColumn<String> originalPrompt = GeneratedColumn<String>(
    'original_prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optimizedPromptMeta = const VerificationMeta(
    'optimizedPrompt',
  );
  @override
  late final GeneratedColumn<String> optimizedPrompt = GeneratedColumn<String>(
    'optimized_prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelKeyMeta = const VerificationMeta(
    'modelKey',
  );
  @override
  late final GeneratedColumn<String> modelKey = GeneratedColumn<String>(
    'model_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    originalPrompt,
    optimizedPrompt,
    type,
    modelKey,
    templateId,
    timestamp,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'optimization_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<OptimizationHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('original_prompt')) {
      context.handle(
        _originalPromptMeta,
        originalPrompt.isAcceptableOrUnknown(
          data['original_prompt']!,
          _originalPromptMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalPromptMeta);
    }
    if (data.containsKey('optimized_prompt')) {
      context.handle(
        _optimizedPromptMeta,
        optimizedPrompt.isAcceptableOrUnknown(
          data['optimized_prompt']!,
          _optimizedPromptMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_optimizedPromptMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('model_key')) {
      context.handle(
        _modelKeyMeta,
        modelKey.isAcceptableOrUnknown(data['model_key']!, _modelKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_modelKeyMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OptimizationHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OptimizationHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      originalPrompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_prompt'],
      )!,
      optimizedPrompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}optimized_prompt'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      modelKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_key'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $OptimizationHistoriesTable createAlias(String alias) {
    return $OptimizationHistoriesTable(attachedDatabase, alias);
  }
}

class OptimizationHistory extends DataClass
    implements Insertable<OptimizationHistory> {
  final String id;
  final String originalPrompt;
  final String optimizedPrompt;
  final String type;
  final String modelKey;
  final String templateId;
  final int timestamp;
  final String metadata;
  const OptimizationHistory({
    required this.id,
    required this.originalPrompt,
    required this.optimizedPrompt,
    required this.type,
    required this.modelKey,
    required this.templateId,
    required this.timestamp,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['original_prompt'] = Variable<String>(originalPrompt);
    map['optimized_prompt'] = Variable<String>(optimizedPrompt);
    map['type'] = Variable<String>(type);
    map['model_key'] = Variable<String>(modelKey);
    map['template_id'] = Variable<String>(templateId);
    map['timestamp'] = Variable<int>(timestamp);
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  OptimizationHistoriesCompanion toCompanion(bool nullToAbsent) {
    return OptimizationHistoriesCompanion(
      id: Value(id),
      originalPrompt: Value(originalPrompt),
      optimizedPrompt: Value(optimizedPrompt),
      type: Value(type),
      modelKey: Value(modelKey),
      templateId: Value(templateId),
      timestamp: Value(timestamp),
      metadata: Value(metadata),
    );
  }

  factory OptimizationHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OptimizationHistory(
      id: serializer.fromJson<String>(json['id']),
      originalPrompt: serializer.fromJson<String>(json['originalPrompt']),
      optimizedPrompt: serializer.fromJson<String>(json['optimizedPrompt']),
      type: serializer.fromJson<String>(json['type']),
      modelKey: serializer.fromJson<String>(json['modelKey']),
      templateId: serializer.fromJson<String>(json['templateId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'originalPrompt': serializer.toJson<String>(originalPrompt),
      'optimizedPrompt': serializer.toJson<String>(optimizedPrompt),
      'type': serializer.toJson<String>(type),
      'modelKey': serializer.toJson<String>(modelKey),
      'templateId': serializer.toJson<String>(templateId),
      'timestamp': serializer.toJson<int>(timestamp),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  OptimizationHistory copyWith({
    String? id,
    String? originalPrompt,
    String? optimizedPrompt,
    String? type,
    String? modelKey,
    String? templateId,
    int? timestamp,
    String? metadata,
  }) => OptimizationHistory(
    id: id ?? this.id,
    originalPrompt: originalPrompt ?? this.originalPrompt,
    optimizedPrompt: optimizedPrompt ?? this.optimizedPrompt,
    type: type ?? this.type,
    modelKey: modelKey ?? this.modelKey,
    templateId: templateId ?? this.templateId,
    timestamp: timestamp ?? this.timestamp,
    metadata: metadata ?? this.metadata,
  );
  OptimizationHistory copyWithCompanion(OptimizationHistoriesCompanion data) {
    return OptimizationHistory(
      id: data.id.present ? data.id.value : this.id,
      originalPrompt: data.originalPrompt.present
          ? data.originalPrompt.value
          : this.originalPrompt,
      optimizedPrompt: data.optimizedPrompt.present
          ? data.optimizedPrompt.value
          : this.optimizedPrompt,
      type: data.type.present ? data.type.value : this.type,
      modelKey: data.modelKey.present ? data.modelKey.value : this.modelKey,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OptimizationHistory(')
          ..write('id: $id, ')
          ..write('originalPrompt: $originalPrompt, ')
          ..write('optimizedPrompt: $optimizedPrompt, ')
          ..write('type: $type, ')
          ..write('modelKey: $modelKey, ')
          ..write('templateId: $templateId, ')
          ..write('timestamp: $timestamp, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originalPrompt,
    optimizedPrompt,
    type,
    modelKey,
    templateId,
    timestamp,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OptimizationHistory &&
          other.id == this.id &&
          other.originalPrompt == this.originalPrompt &&
          other.optimizedPrompt == this.optimizedPrompt &&
          other.type == this.type &&
          other.modelKey == this.modelKey &&
          other.templateId == this.templateId &&
          other.timestamp == this.timestamp &&
          other.metadata == this.metadata);
}

class OptimizationHistoriesCompanion
    extends UpdateCompanion<OptimizationHistory> {
  final Value<String> id;
  final Value<String> originalPrompt;
  final Value<String> optimizedPrompt;
  final Value<String> type;
  final Value<String> modelKey;
  final Value<String> templateId;
  final Value<int> timestamp;
  final Value<String> metadata;
  final Value<int> rowid;
  const OptimizationHistoriesCompanion({
    this.id = const Value.absent(),
    this.originalPrompt = const Value.absent(),
    this.optimizedPrompt = const Value.absent(),
    this.type = const Value.absent(),
    this.modelKey = const Value.absent(),
    this.templateId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OptimizationHistoriesCompanion.insert({
    required String id,
    required String originalPrompt,
    required String optimizedPrompt,
    required String type,
    required String modelKey,
    required String templateId,
    required int timestamp,
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       originalPrompt = Value(originalPrompt),
       optimizedPrompt = Value(optimizedPrompt),
       type = Value(type),
       modelKey = Value(modelKey),
       templateId = Value(templateId),
       timestamp = Value(timestamp);
  static Insertable<OptimizationHistory> custom({
    Expression<String>? id,
    Expression<String>? originalPrompt,
    Expression<String>? optimizedPrompt,
    Expression<String>? type,
    Expression<String>? modelKey,
    Expression<String>? templateId,
    Expression<int>? timestamp,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalPrompt != null) 'original_prompt': originalPrompt,
      if (optimizedPrompt != null) 'optimized_prompt': optimizedPrompt,
      if (type != null) 'type': type,
      if (modelKey != null) 'model_key': modelKey,
      if (templateId != null) 'template_id': templateId,
      if (timestamp != null) 'timestamp': timestamp,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OptimizationHistoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? originalPrompt,
    Value<String>? optimizedPrompt,
    Value<String>? type,
    Value<String>? modelKey,
    Value<String>? templateId,
    Value<int>? timestamp,
    Value<String>? metadata,
    Value<int>? rowid,
  }) {
    return OptimizationHistoriesCompanion(
      id: id ?? this.id,
      originalPrompt: originalPrompt ?? this.originalPrompt,
      optimizedPrompt: optimizedPrompt ?? this.optimizedPrompt,
      type: type ?? this.type,
      modelKey: modelKey ?? this.modelKey,
      templateId: templateId ?? this.templateId,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (originalPrompt.present) {
      map['original_prompt'] = Variable<String>(originalPrompt.value);
    }
    if (optimizedPrompt.present) {
      map['optimized_prompt'] = Variable<String>(optimizedPrompt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (modelKey.present) {
      map['model_key'] = Variable<String>(modelKey.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OptimizationHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('originalPrompt: $originalPrompt, ')
          ..write('optimizedPrompt: $optimizedPrompt, ')
          ..write('type: $type, ')
          ..write('modelKey: $modelKey, ')
          ..write('templateId: $templateId, ')
          ..write('timestamp: $timestamp, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ApiConfigsTable apiConfigs = $ApiConfigsTable(this);
  late final $PromptTemplatesTable promptTemplates = $PromptTemplatesTable(
    this,
  );
  late final $OptimizationHistoriesTable optimizationHistories =
      $OptimizationHistoriesTable(this);
  late final ApiConfigDao apiConfigDao = ApiConfigDao(this as AppDatabase);
  late final TemplateDao templateDao = TemplateDao(this as AppDatabase);
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    apiConfigs,
    promptTemplates,
    optimizationHistories,
  ];
}

typedef $$ApiConfigsTableCreateCompanionBuilder =
    ApiConfigsCompanion Function({
      required String id,
      required String name,
      required String apiKey,
      Value<String> baseUrl,
      Value<String> modelId,
      Value<bool> isEnabled,
      Value<int> createdAt,
      Value<int> rowid,
    });
typedef $$ApiConfigsTableUpdateCompanionBuilder =
    ApiConfigsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> apiKey,
      Value<String> baseUrl,
      Value<String> modelId,
      Value<bool> isEnabled,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$ApiConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $ApiConfigsTable> {
  $$ApiConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApiConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApiConfigsTable> {
  $$ApiConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiKey => $composableBuilder(
    column: $table.apiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApiConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApiConfigsTable> {
  $$ApiConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get apiKey =>
      $composableBuilder(column: $table.apiKey, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get modelId =>
      $composableBuilder(column: $table.modelId, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ApiConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApiConfigsTable,
          ApiConfig,
          $$ApiConfigsTableFilterComposer,
          $$ApiConfigsTableOrderingComposer,
          $$ApiConfigsTableAnnotationComposer,
          $$ApiConfigsTableCreateCompanionBuilder,
          $$ApiConfigsTableUpdateCompanionBuilder,
          (
            ApiConfig,
            BaseReferences<_$AppDatabase, $ApiConfigsTable, ApiConfig>,
          ),
          ApiConfig,
          PrefetchHooks Function()
        > {
  $$ApiConfigsTableTableManager(_$AppDatabase db, $ApiConfigsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> apiKey = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> modelId = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApiConfigsCompanion(
                id: id,
                name: name,
                apiKey: apiKey,
                baseUrl: baseUrl,
                modelId: modelId,
                isEnabled: isEnabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String apiKey,
                Value<String> baseUrl = const Value.absent(),
                Value<String> modelId = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApiConfigsCompanion.insert(
                id: id,
                name: name,
                apiKey: apiKey,
                baseUrl: baseUrl,
                modelId: modelId,
                isEnabled: isEnabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ApiConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApiConfigsTable,
      ApiConfig,
      $$ApiConfigsTableFilterComposer,
      $$ApiConfigsTableOrderingComposer,
      $$ApiConfigsTableAnnotationComposer,
      $$ApiConfigsTableCreateCompanionBuilder,
      $$ApiConfigsTableUpdateCompanionBuilder,
      (ApiConfig, BaseReferences<_$AppDatabase, $ApiConfigsTable, ApiConfig>),
      ApiConfig,
      PrefetchHooks Function()
    >;
typedef $$PromptTemplatesTableCreateCompanionBuilder =
    PromptTemplatesCompanion Function({
      required String id,
      required String name,
      required String content,
      required String templateType,
      Value<String> description,
      Value<String> author,
      Value<String> version,
      Value<bool> isBuiltin,
      required int lastModified,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$PromptTemplatesTableUpdateCompanionBuilder =
    PromptTemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> content,
      Value<String> templateType,
      Value<String> description,
      Value<String> author,
      Value<String> version,
      Value<bool> isBuiltin,
      Value<int> lastModified,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$PromptTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $PromptTemplatesTable> {
  $$PromptTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PromptTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $PromptTemplatesTable> {
  $$PromptTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltin => $composableBuilder(
    column: $table.isBuiltin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PromptTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PromptTemplatesTable> {
  $$PromptTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get templateType => $composableBuilder(
    column: $table.templateType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get isBuiltin =>
      $composableBuilder(column: $table.isBuiltin, builder: (column) => column);

  GeneratedColumn<int> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PromptTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PromptTemplatesTable,
          PromptTemplate,
          $$PromptTemplatesTableFilterComposer,
          $$PromptTemplatesTableOrderingComposer,
          $$PromptTemplatesTableAnnotationComposer,
          $$PromptTemplatesTableCreateCompanionBuilder,
          $$PromptTemplatesTableUpdateCompanionBuilder,
          (
            PromptTemplate,
            BaseReferences<
              _$AppDatabase,
              $PromptTemplatesTable,
              PromptTemplate
            >,
          ),
          PromptTemplate,
          PrefetchHooks Function()
        > {
  $$PromptTemplatesTableTableManager(
    _$AppDatabase db,
    $PromptTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromptTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromptTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromptTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> templateType = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                Value<int> lastModified = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromptTemplatesCompanion(
                id: id,
                name: name,
                content: content,
                templateType: templateType,
                description: description,
                author: author,
                version: version,
                isBuiltin: isBuiltin,
                lastModified: lastModified,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String content,
                required String templateType,
                Value<String> description = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<bool> isBuiltin = const Value.absent(),
                required int lastModified,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PromptTemplatesCompanion.insert(
                id: id,
                name: name,
                content: content,
                templateType: templateType,
                description: description,
                author: author,
                version: version,
                isBuiltin: isBuiltin,
                lastModified: lastModified,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PromptTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PromptTemplatesTable,
      PromptTemplate,
      $$PromptTemplatesTableFilterComposer,
      $$PromptTemplatesTableOrderingComposer,
      $$PromptTemplatesTableAnnotationComposer,
      $$PromptTemplatesTableCreateCompanionBuilder,
      $$PromptTemplatesTableUpdateCompanionBuilder,
      (
        PromptTemplate,
        BaseReferences<_$AppDatabase, $PromptTemplatesTable, PromptTemplate>,
      ),
      PromptTemplate,
      PrefetchHooks Function()
    >;
typedef $$OptimizationHistoriesTableCreateCompanionBuilder =
    OptimizationHistoriesCompanion Function({
      required String id,
      required String originalPrompt,
      required String optimizedPrompt,
      required String type,
      required String modelKey,
      required String templateId,
      required int timestamp,
      Value<String> metadata,
      Value<int> rowid,
    });
typedef $$OptimizationHistoriesTableUpdateCompanionBuilder =
    OptimizationHistoriesCompanion Function({
      Value<String> id,
      Value<String> originalPrompt,
      Value<String> optimizedPrompt,
      Value<String> type,
      Value<String> modelKey,
      Value<String> templateId,
      Value<int> timestamp,
      Value<String> metadata,
      Value<int> rowid,
    });

class $$OptimizationHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $OptimizationHistoriesTable> {
  $$OptimizationHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalPrompt => $composableBuilder(
    column: $table.originalPrompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optimizedPrompt => $composableBuilder(
    column: $table.optimizedPrompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelKey => $composableBuilder(
    column: $table.modelKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OptimizationHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OptimizationHistoriesTable> {
  $$OptimizationHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalPrompt => $composableBuilder(
    column: $table.originalPrompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optimizedPrompt => $composableBuilder(
    column: $table.optimizedPrompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelKey => $composableBuilder(
    column: $table.modelKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OptimizationHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OptimizationHistoriesTable> {
  $$OptimizationHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get originalPrompt => $composableBuilder(
    column: $table.originalPrompt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optimizedPrompt => $composableBuilder(
    column: $table.optimizedPrompt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get modelKey =>
      $composableBuilder(column: $table.modelKey, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$OptimizationHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OptimizationHistoriesTable,
          OptimizationHistory,
          $$OptimizationHistoriesTableFilterComposer,
          $$OptimizationHistoriesTableOrderingComposer,
          $$OptimizationHistoriesTableAnnotationComposer,
          $$OptimizationHistoriesTableCreateCompanionBuilder,
          $$OptimizationHistoriesTableUpdateCompanionBuilder,
          (
            OptimizationHistory,
            BaseReferences<
              _$AppDatabase,
              $OptimizationHistoriesTable,
              OptimizationHistory
            >,
          ),
          OptimizationHistory,
          PrefetchHooks Function()
        > {
  $$OptimizationHistoriesTableTableManager(
    _$AppDatabase db,
    $OptimizationHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OptimizationHistoriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$OptimizationHistoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$OptimizationHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> originalPrompt = const Value.absent(),
                Value<String> optimizedPrompt = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> modelKey = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OptimizationHistoriesCompanion(
                id: id,
                originalPrompt: originalPrompt,
                optimizedPrompt: optimizedPrompt,
                type: type,
                modelKey: modelKey,
                templateId: templateId,
                timestamp: timestamp,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String originalPrompt,
                required String optimizedPrompt,
                required String type,
                required String modelKey,
                required String templateId,
                required int timestamp,
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OptimizationHistoriesCompanion.insert(
                id: id,
                originalPrompt: originalPrompt,
                optimizedPrompt: optimizedPrompt,
                type: type,
                modelKey: modelKey,
                templateId: templateId,
                timestamp: timestamp,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OptimizationHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OptimizationHistoriesTable,
      OptimizationHistory,
      $$OptimizationHistoriesTableFilterComposer,
      $$OptimizationHistoriesTableOrderingComposer,
      $$OptimizationHistoriesTableAnnotationComposer,
      $$OptimizationHistoriesTableCreateCompanionBuilder,
      $$OptimizationHistoriesTableUpdateCompanionBuilder,
      (
        OptimizationHistory,
        BaseReferences<
          _$AppDatabase,
          $OptimizationHistoriesTable,
          OptimizationHistory
        >,
      ),
      OptimizationHistory,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ApiConfigsTableTableManager get apiConfigs =>
      $$ApiConfigsTableTableManager(_db, _db.apiConfigs);
  $$PromptTemplatesTableTableManager get promptTemplates =>
      $$PromptTemplatesTableTableManager(_db, _db.promptTemplates);
  $$OptimizationHistoriesTableTableManager get optimizationHistories =>
      $$OptimizationHistoriesTableTableManager(_db, _db.optimizationHistories);
}
