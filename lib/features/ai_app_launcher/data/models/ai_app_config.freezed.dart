// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AIAppConfigModel {

 String get id; String get name; String get scheme; String get iconPath; bool get isEnabled; int get position; bool get isBuiltin; DateTime get createdAt;
/// Create a copy of AIAppConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIAppConfigModelCopyWith<AIAppConfigModel> get copyWith => _$AIAppConfigModelCopyWithImpl<AIAppConfigModel>(this as AIAppConfigModel, _$identity);

  /// Serializes this AIAppConfigModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIAppConfigModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scheme, scheme) || other.scheme == scheme)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.position, position) || other.position == position)&&(identical(other.isBuiltin, isBuiltin) || other.isBuiltin == isBuiltin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,scheme,iconPath,isEnabled,position,isBuiltin,createdAt);

@override
String toString() {
  return 'AIAppConfigModel(id: $id, name: $name, scheme: $scheme, iconPath: $iconPath, isEnabled: $isEnabled, position: $position, isBuiltin: $isBuiltin, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AIAppConfigModelCopyWith<$Res>  {
  factory $AIAppConfigModelCopyWith(AIAppConfigModel value, $Res Function(AIAppConfigModel) _then) = _$AIAppConfigModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String scheme, String iconPath, bool isEnabled, int position, bool isBuiltin, DateTime createdAt
});




}
/// @nodoc
class _$AIAppConfigModelCopyWithImpl<$Res>
    implements $AIAppConfigModelCopyWith<$Res> {
  _$AIAppConfigModelCopyWithImpl(this._self, this._then);

  final AIAppConfigModel _self;
  final $Res Function(AIAppConfigModel) _then;

/// Create a copy of AIAppConfigModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? scheme = null,Object? iconPath = null,Object? isEnabled = null,Object? position = null,Object? isBuiltin = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scheme: null == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,isBuiltin: null == isBuiltin ? _self.isBuiltin : isBuiltin // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AIAppConfigModel].
extension AIAppConfigModelPatterns on AIAppConfigModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AIAppConfigModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AIAppConfigModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AIAppConfigModel value)  $default,){
final _that = this;
switch (_that) {
case _AIAppConfigModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AIAppConfigModel value)?  $default,){
final _that = this;
switch (_that) {
case _AIAppConfigModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String scheme,  String iconPath,  bool isEnabled,  int position,  bool isBuiltin,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AIAppConfigModel() when $default != null:
return $default(_that.id,_that.name,_that.scheme,_that.iconPath,_that.isEnabled,_that.position,_that.isBuiltin,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String scheme,  String iconPath,  bool isEnabled,  int position,  bool isBuiltin,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AIAppConfigModel():
return $default(_that.id,_that.name,_that.scheme,_that.iconPath,_that.isEnabled,_that.position,_that.isBuiltin,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String scheme,  String iconPath,  bool isEnabled,  int position,  bool isBuiltin,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AIAppConfigModel() when $default != null:
return $default(_that.id,_that.name,_that.scheme,_that.iconPath,_that.isEnabled,_that.position,_that.isBuiltin,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AIAppConfigModel extends AIAppConfigModel {
  const _AIAppConfigModel({required this.id, required this.name, required this.scheme, required this.iconPath, this.isEnabled = true, this.position = 0, this.isBuiltin = false, required this.createdAt}): super._();
  factory _AIAppConfigModel.fromJson(Map<String, dynamic> json) => _$AIAppConfigModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String scheme;
@override final  String iconPath;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  int position;
@override@JsonKey() final  bool isBuiltin;
@override final  DateTime createdAt;

/// Create a copy of AIAppConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIAppConfigModelCopyWith<_AIAppConfigModel> get copyWith => __$AIAppConfigModelCopyWithImpl<_AIAppConfigModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIAppConfigModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIAppConfigModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scheme, scheme) || other.scheme == scheme)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.position, position) || other.position == position)&&(identical(other.isBuiltin, isBuiltin) || other.isBuiltin == isBuiltin)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,scheme,iconPath,isEnabled,position,isBuiltin,createdAt);

@override
String toString() {
  return 'AIAppConfigModel(id: $id, name: $name, scheme: $scheme, iconPath: $iconPath, isEnabled: $isEnabled, position: $position, isBuiltin: $isBuiltin, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AIAppConfigModelCopyWith<$Res> implements $AIAppConfigModelCopyWith<$Res> {
  factory _$AIAppConfigModelCopyWith(_AIAppConfigModel value, $Res Function(_AIAppConfigModel) _then) = __$AIAppConfigModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String scheme, String iconPath, bool isEnabled, int position, bool isBuiltin, DateTime createdAt
});




}
/// @nodoc
class __$AIAppConfigModelCopyWithImpl<$Res>
    implements _$AIAppConfigModelCopyWith<$Res> {
  __$AIAppConfigModelCopyWithImpl(this._self, this._then);

  final _AIAppConfigModel _self;
  final $Res Function(_AIAppConfigModel) _then;

/// Create a copy of AIAppConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? scheme = null,Object? iconPath = null,Object? isEnabled = null,Object? position = null,Object? isBuiltin = null,Object? createdAt = null,}) {
  return _then(_AIAppConfigModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scheme: null == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,isBuiltin: null == isBuiltin ? _self.isBuiltin : isBuiltin // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
