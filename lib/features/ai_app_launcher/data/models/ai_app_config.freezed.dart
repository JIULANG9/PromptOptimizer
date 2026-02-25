// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AIAppConfigModel _$AIAppConfigModelFromJson(Map<String, dynamic> json) {
  return _AIAppConfigModel.fromJson(json);
}

/// @nodoc
mixin _$AIAppConfigModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get scheme => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  bool get isBuiltin => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AIAppConfigModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AIAppConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AIAppConfigModelCopyWith<AIAppConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIAppConfigModelCopyWith<$Res> {
  factory $AIAppConfigModelCopyWith(
    AIAppConfigModel value,
    $Res Function(AIAppConfigModel) then,
  ) = _$AIAppConfigModelCopyWithImpl<$Res, AIAppConfigModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String scheme,
    String iconPath,
    bool isEnabled,
    int position,
    bool isBuiltin,
    DateTime createdAt,
  });
}

/// @nodoc
class _$AIAppConfigModelCopyWithImpl<$Res, $Val extends AIAppConfigModel>
    implements $AIAppConfigModelCopyWith<$Res> {
  _$AIAppConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AIAppConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? scheme = null,
    Object? iconPath = null,
    Object? isEnabled = null,
    Object? position = null,
    Object? isBuiltin = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            scheme: null == scheme
                ? _value.scheme
                : scheme // ignore: cast_nullable_to_non_nullable
                      as String,
            iconPath: null == iconPath
                ? _value.iconPath
                : iconPath // ignore: cast_nullable_to_non_nullable
                      as String,
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            isBuiltin: null == isBuiltin
                ? _value.isBuiltin
                : isBuiltin // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AIAppConfigModelImplCopyWith<$Res>
    implements $AIAppConfigModelCopyWith<$Res> {
  factory _$$AIAppConfigModelImplCopyWith(
    _$AIAppConfigModelImpl value,
    $Res Function(_$AIAppConfigModelImpl) then,
  ) = __$$AIAppConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String scheme,
    String iconPath,
    bool isEnabled,
    int position,
    bool isBuiltin,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$AIAppConfigModelImplCopyWithImpl<$Res>
    extends _$AIAppConfigModelCopyWithImpl<$Res, _$AIAppConfigModelImpl>
    implements _$$AIAppConfigModelImplCopyWith<$Res> {
  __$$AIAppConfigModelImplCopyWithImpl(
    _$AIAppConfigModelImpl _value,
    $Res Function(_$AIAppConfigModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AIAppConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? scheme = null,
    Object? iconPath = null,
    Object? isEnabled = null,
    Object? position = null,
    Object? isBuiltin = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$AIAppConfigModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        scheme: null == scheme
            ? _value.scheme
            : scheme // ignore: cast_nullable_to_non_nullable
                  as String,
        iconPath: null == iconPath
            ? _value.iconPath
            : iconPath // ignore: cast_nullable_to_non_nullable
                  as String,
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        isBuiltin: null == isBuiltin
            ? _value.isBuiltin
            : isBuiltin // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AIAppConfigModelImpl extends _AIAppConfigModel {
  const _$AIAppConfigModelImpl({
    required this.id,
    required this.name,
    required this.scheme,
    required this.iconPath,
    this.isEnabled = true,
    this.position = 0,
    this.isBuiltin = false,
    required this.createdAt,
  }) : super._();

  factory _$AIAppConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIAppConfigModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String scheme;
  @override
  final String iconPath;
  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final int position;
  @override
  @JsonKey()
  final bool isBuiltin;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AIAppConfigModel(id: $id, name: $name, scheme: $scheme, iconPath: $iconPath, isEnabled: $isEnabled, position: $position, isBuiltin: $isBuiltin, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIAppConfigModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.scheme, scheme) || other.scheme == scheme) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isBuiltin, isBuiltin) ||
                other.isBuiltin == isBuiltin) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    scheme,
    iconPath,
    isEnabled,
    position,
    isBuiltin,
    createdAt,
  );

  /// Create a copy of AIAppConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AIAppConfigModelImplCopyWith<_$AIAppConfigModelImpl> get copyWith =>
      __$$AIAppConfigModelImplCopyWithImpl<_$AIAppConfigModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AIAppConfigModelImplToJson(this);
  }
}

abstract class _AIAppConfigModel extends AIAppConfigModel {
  const factory _AIAppConfigModel({
    required final String id,
    required final String name,
    required final String scheme,
    required final String iconPath,
    final bool isEnabled,
    final int position,
    final bool isBuiltin,
    required final DateTime createdAt,
  }) = _$AIAppConfigModelImpl;
  const _AIAppConfigModel._() : super._();

  factory _AIAppConfigModel.fromJson(Map<String, dynamic> json) =
      _$AIAppConfigModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get scheme;
  @override
  String get iconPath;
  @override
  bool get isEnabled;
  @override
  int get position;
  @override
  bool get isBuiltin;
  @override
  DateTime get createdAt;

  /// Create a copy of AIAppConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AIAppConfigModelImplCopyWith<_$AIAppConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
