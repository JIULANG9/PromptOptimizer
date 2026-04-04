// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VersionResponse {

@JsonKey(name: 'PromptOptimizer') PromptOptimizerVersion get promptOptimizer;
/// Create a copy of VersionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersionResponseCopyWith<VersionResponse> get copyWith => _$VersionResponseCopyWithImpl<VersionResponse>(this as VersionResponse, _$identity);

  /// Serializes this VersionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersionResponse&&(identical(other.promptOptimizer, promptOptimizer) || other.promptOptimizer == promptOptimizer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,promptOptimizer);

@override
String toString() {
  return 'VersionResponse(promptOptimizer: $promptOptimizer)';
}


}

/// @nodoc
abstract mixin class $VersionResponseCopyWith<$Res>  {
  factory $VersionResponseCopyWith(VersionResponse value, $Res Function(VersionResponse) _then) = _$VersionResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'PromptOptimizer') PromptOptimizerVersion promptOptimizer
});


$PromptOptimizerVersionCopyWith<$Res> get promptOptimizer;

}
/// @nodoc
class _$VersionResponseCopyWithImpl<$Res>
    implements $VersionResponseCopyWith<$Res> {
  _$VersionResponseCopyWithImpl(this._self, this._then);

  final VersionResponse _self;
  final $Res Function(VersionResponse) _then;

/// Create a copy of VersionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? promptOptimizer = null,}) {
  return _then(_self.copyWith(
promptOptimizer: null == promptOptimizer ? _self.promptOptimizer : promptOptimizer // ignore: cast_nullable_to_non_nullable
as PromptOptimizerVersion,
  ));
}
/// Create a copy of VersionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PromptOptimizerVersionCopyWith<$Res> get promptOptimizer {
  
  return $PromptOptimizerVersionCopyWith<$Res>(_self.promptOptimizer, (value) {
    return _then(_self.copyWith(promptOptimizer: value));
  });
}
}


/// Adds pattern-matching-related methods to [VersionResponse].
extension VersionResponsePatterns on VersionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VersionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VersionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VersionResponse value)  $default,){
final _that = this;
switch (_that) {
case _VersionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VersionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VersionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'PromptOptimizer')  PromptOptimizerVersion promptOptimizer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VersionResponse() when $default != null:
return $default(_that.promptOptimizer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'PromptOptimizer')  PromptOptimizerVersion promptOptimizer)  $default,) {final _that = this;
switch (_that) {
case _VersionResponse():
return $default(_that.promptOptimizer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'PromptOptimizer')  PromptOptimizerVersion promptOptimizer)?  $default,) {final _that = this;
switch (_that) {
case _VersionResponse() when $default != null:
return $default(_that.promptOptimizer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VersionResponse implements VersionResponse {
  const _VersionResponse({@JsonKey(name: 'PromptOptimizer') required this.promptOptimizer});
  factory _VersionResponse.fromJson(Map<String, dynamic> json) => _$VersionResponseFromJson(json);

@override@JsonKey(name: 'PromptOptimizer') final  PromptOptimizerVersion promptOptimizer;

/// Create a copy of VersionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersionResponseCopyWith<_VersionResponse> get copyWith => __$VersionResponseCopyWithImpl<_VersionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VersionResponse&&(identical(other.promptOptimizer, promptOptimizer) || other.promptOptimizer == promptOptimizer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,promptOptimizer);

@override
String toString() {
  return 'VersionResponse(promptOptimizer: $promptOptimizer)';
}


}

/// @nodoc
abstract mixin class _$VersionResponseCopyWith<$Res> implements $VersionResponseCopyWith<$Res> {
  factory _$VersionResponseCopyWith(_VersionResponse value, $Res Function(_VersionResponse) _then) = __$VersionResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'PromptOptimizer') PromptOptimizerVersion promptOptimizer
});


@override $PromptOptimizerVersionCopyWith<$Res> get promptOptimizer;

}
/// @nodoc
class __$VersionResponseCopyWithImpl<$Res>
    implements _$VersionResponseCopyWith<$Res> {
  __$VersionResponseCopyWithImpl(this._self, this._then);

  final _VersionResponse _self;
  final $Res Function(_VersionResponse) _then;

/// Create a copy of VersionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? promptOptimizer = null,}) {
  return _then(_VersionResponse(
promptOptimizer: null == promptOptimizer ? _self.promptOptimizer : promptOptimizer // ignore: cast_nullable_to_non_nullable
as PromptOptimizerVersion,
  ));
}

/// Create a copy of VersionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PromptOptimizerVersionCopyWith<$Res> get promptOptimizer {
  
  return $PromptOptimizerVersionCopyWith<$Res>(_self.promptOptimizer, (value) {
    return _then(_self.copyWith(promptOptimizer: value));
  });
}
}


/// @nodoc
mixin _$PromptOptimizerVersion {

 int get versionCode; String get versionName; String get downloadUrl; String get updateMsg;
/// Create a copy of PromptOptimizerVersion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromptOptimizerVersionCopyWith<PromptOptimizerVersion> get copyWith => _$PromptOptimizerVersionCopyWithImpl<PromptOptimizerVersion>(this as PromptOptimizerVersion, _$identity);

  /// Serializes this PromptOptimizerVersion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromptOptimizerVersion&&(identical(other.versionCode, versionCode) || other.versionCode == versionCode)&&(identical(other.versionName, versionName) || other.versionName == versionName)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.updateMsg, updateMsg) || other.updateMsg == updateMsg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,versionCode,versionName,downloadUrl,updateMsg);

@override
String toString() {
  return 'PromptOptimizerVersion(versionCode: $versionCode, versionName: $versionName, downloadUrl: $downloadUrl, updateMsg: $updateMsg)';
}


}

/// @nodoc
abstract mixin class $PromptOptimizerVersionCopyWith<$Res>  {
  factory $PromptOptimizerVersionCopyWith(PromptOptimizerVersion value, $Res Function(PromptOptimizerVersion) _then) = _$PromptOptimizerVersionCopyWithImpl;
@useResult
$Res call({
 int versionCode, String versionName, String downloadUrl, String updateMsg
});




}
/// @nodoc
class _$PromptOptimizerVersionCopyWithImpl<$Res>
    implements $PromptOptimizerVersionCopyWith<$Res> {
  _$PromptOptimizerVersionCopyWithImpl(this._self, this._then);

  final PromptOptimizerVersion _self;
  final $Res Function(PromptOptimizerVersion) _then;

/// Create a copy of PromptOptimizerVersion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? versionCode = null,Object? versionName = null,Object? downloadUrl = null,Object? updateMsg = null,}) {
  return _then(_self.copyWith(
versionCode: null == versionCode ? _self.versionCode : versionCode // ignore: cast_nullable_to_non_nullable
as int,versionName: null == versionName ? _self.versionName : versionName // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,updateMsg: null == updateMsg ? _self.updateMsg : updateMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PromptOptimizerVersion].
extension PromptOptimizerVersionPatterns on PromptOptimizerVersion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromptOptimizerVersion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromptOptimizerVersion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromptOptimizerVersion value)  $default,){
final _that = this;
switch (_that) {
case _PromptOptimizerVersion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromptOptimizerVersion value)?  $default,){
final _that = this;
switch (_that) {
case _PromptOptimizerVersion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int versionCode,  String versionName,  String downloadUrl,  String updateMsg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromptOptimizerVersion() when $default != null:
return $default(_that.versionCode,_that.versionName,_that.downloadUrl,_that.updateMsg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int versionCode,  String versionName,  String downloadUrl,  String updateMsg)  $default,) {final _that = this;
switch (_that) {
case _PromptOptimizerVersion():
return $default(_that.versionCode,_that.versionName,_that.downloadUrl,_that.updateMsg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int versionCode,  String versionName,  String downloadUrl,  String updateMsg)?  $default,) {final _that = this;
switch (_that) {
case _PromptOptimizerVersion() when $default != null:
return $default(_that.versionCode,_that.versionName,_that.downloadUrl,_that.updateMsg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PromptOptimizerVersion implements PromptOptimizerVersion {
  const _PromptOptimizerVersion({required this.versionCode, required this.versionName, required this.downloadUrl, required this.updateMsg});
  factory _PromptOptimizerVersion.fromJson(Map<String, dynamic> json) => _$PromptOptimizerVersionFromJson(json);

@override final  int versionCode;
@override final  String versionName;
@override final  String downloadUrl;
@override final  String updateMsg;

/// Create a copy of PromptOptimizerVersion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromptOptimizerVersionCopyWith<_PromptOptimizerVersion> get copyWith => __$PromptOptimizerVersionCopyWithImpl<_PromptOptimizerVersion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PromptOptimizerVersionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromptOptimizerVersion&&(identical(other.versionCode, versionCode) || other.versionCode == versionCode)&&(identical(other.versionName, versionName) || other.versionName == versionName)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.updateMsg, updateMsg) || other.updateMsg == updateMsg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,versionCode,versionName,downloadUrl,updateMsg);

@override
String toString() {
  return 'PromptOptimizerVersion(versionCode: $versionCode, versionName: $versionName, downloadUrl: $downloadUrl, updateMsg: $updateMsg)';
}


}

/// @nodoc
abstract mixin class _$PromptOptimizerVersionCopyWith<$Res> implements $PromptOptimizerVersionCopyWith<$Res> {
  factory _$PromptOptimizerVersionCopyWith(_PromptOptimizerVersion value, $Res Function(_PromptOptimizerVersion) _then) = __$PromptOptimizerVersionCopyWithImpl;
@override @useResult
$Res call({
 int versionCode, String versionName, String downloadUrl, String updateMsg
});




}
/// @nodoc
class __$PromptOptimizerVersionCopyWithImpl<$Res>
    implements _$PromptOptimizerVersionCopyWith<$Res> {
  __$PromptOptimizerVersionCopyWithImpl(this._self, this._then);

  final _PromptOptimizerVersion _self;
  final $Res Function(_PromptOptimizerVersion) _then;

/// Create a copy of PromptOptimizerVersion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? versionCode = null,Object? versionName = null,Object? downloadUrl = null,Object? updateMsg = null,}) {
  return _then(_PromptOptimizerVersion(
versionCode: null == versionCode ? _self.versionCode : versionCode // ignore: cast_nullable_to_non_nullable
as int,versionName: null == versionName ? _self.versionName : versionName // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,updateMsg: null == updateMsg ? _self.updateMsg : updateMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
