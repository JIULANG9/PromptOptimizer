// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toast_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToastAction {

 String get label; VoidCallback get onPressed;
/// Create a copy of ToastAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToastActionCopyWith<ToastAction> get copyWith => _$ToastActionCopyWithImpl<ToastAction>(this as ToastAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToastAction&&(identical(other.label, label) || other.label == label)&&(identical(other.onPressed, onPressed) || other.onPressed == onPressed));
}


@override
int get hashCode => Object.hash(runtimeType,label,onPressed);

@override
String toString() {
  return 'ToastAction(label: $label, onPressed: $onPressed)';
}


}

/// @nodoc
abstract mixin class $ToastActionCopyWith<$Res>  {
  factory $ToastActionCopyWith(ToastAction value, $Res Function(ToastAction) _then) = _$ToastActionCopyWithImpl;
@useResult
$Res call({
 String label, VoidCallback onPressed
});




}
/// @nodoc
class _$ToastActionCopyWithImpl<$Res>
    implements $ToastActionCopyWith<$Res> {
  _$ToastActionCopyWithImpl(this._self, this._then);

  final ToastAction _self;
  final $Res Function(ToastAction) _then;

/// Create a copy of ToastAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? onPressed = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,onPressed: null == onPressed ? _self.onPressed : onPressed // ignore: cast_nullable_to_non_nullable
as VoidCallback,
  ));
}

}


/// Adds pattern-matching-related methods to [ToastAction].
extension ToastActionPatterns on ToastAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToastAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToastAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToastAction value)  $default,){
final _that = this;
switch (_that) {
case _ToastAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToastAction value)?  $default,){
final _that = this;
switch (_that) {
case _ToastAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  VoidCallback onPressed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToastAction() when $default != null:
return $default(_that.label,_that.onPressed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  VoidCallback onPressed)  $default,) {final _that = this;
switch (_that) {
case _ToastAction():
return $default(_that.label,_that.onPressed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  VoidCallback onPressed)?  $default,) {final _that = this;
switch (_that) {
case _ToastAction() when $default != null:
return $default(_that.label,_that.onPressed);case _:
  return null;

}
}

}

/// @nodoc


class _ToastAction implements ToastAction {
  const _ToastAction({required this.label, required this.onPressed});
  

@override final  String label;
@override final  VoidCallback onPressed;

/// Create a copy of ToastAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToastActionCopyWith<_ToastAction> get copyWith => __$ToastActionCopyWithImpl<_ToastAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToastAction&&(identical(other.label, label) || other.label == label)&&(identical(other.onPressed, onPressed) || other.onPressed == onPressed));
}


@override
int get hashCode => Object.hash(runtimeType,label,onPressed);

@override
String toString() {
  return 'ToastAction(label: $label, onPressed: $onPressed)';
}


}

/// @nodoc
abstract mixin class _$ToastActionCopyWith<$Res> implements $ToastActionCopyWith<$Res> {
  factory _$ToastActionCopyWith(_ToastAction value, $Res Function(_ToastAction) _then) = __$ToastActionCopyWithImpl;
@override @useResult
$Res call({
 String label, VoidCallback onPressed
});




}
/// @nodoc
class __$ToastActionCopyWithImpl<$Res>
    implements _$ToastActionCopyWith<$Res> {
  __$ToastActionCopyWithImpl(this._self, this._then);

  final _ToastAction _self;
  final $Res Function(_ToastAction) _then;

/// Create a copy of ToastAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? onPressed = null,}) {
  return _then(_ToastAction(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,onPressed: null == onPressed ? _self.onPressed : onPressed // ignore: cast_nullable_to_non_nullable
as VoidCallback,
  ));
}


}

/// @nodoc
mixin _$ToastRequest {

/// 唯一标识，用于进度更新或手动移除
 String? get id;/// Toast 类型
 ToastType get type;/// 显示消息
 String get message;/// 显示时长，null 则使用默认时长
 Duration? get duration;/// 自定义图标
 Widget? get icon;/// 进度值 (0.0 - 1.0), 仅 type == progress 有效
 double? get progress;/// 显示位置
 ToastPosition get position;/// 主操作按钮
 ToastAction? get primaryAction;/// 次要操作按钮
 ToastAction? get secondaryAction;/// 消失时的回调
 VoidCallback? get onDismissed;
/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToastRequestCopyWith<ToastRequest> get copyWith => _$ToastRequestCopyWithImpl<ToastRequest>(this as ToastRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToastRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.position, position) || other.position == position)&&(identical(other.primaryAction, primaryAction) || other.primaryAction == primaryAction)&&(identical(other.secondaryAction, secondaryAction) || other.secondaryAction == secondaryAction)&&(identical(other.onDismissed, onDismissed) || other.onDismissed == onDismissed));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,message,duration,icon,progress,position,primaryAction,secondaryAction,onDismissed);

@override
String toString() {
  return 'ToastRequest(id: $id, type: $type, message: $message, duration: $duration, icon: $icon, progress: $progress, position: $position, primaryAction: $primaryAction, secondaryAction: $secondaryAction, onDismissed: $onDismissed)';
}


}

/// @nodoc
abstract mixin class $ToastRequestCopyWith<$Res>  {
  factory $ToastRequestCopyWith(ToastRequest value, $Res Function(ToastRequest) _then) = _$ToastRequestCopyWithImpl;
@useResult
$Res call({
 String? id, ToastType type, String message, Duration? duration, Widget? icon, double? progress, ToastPosition position, ToastAction? primaryAction, ToastAction? secondaryAction, VoidCallback? onDismissed
});


$ToastActionCopyWith<$Res>? get primaryAction;$ToastActionCopyWith<$Res>? get secondaryAction;

}
/// @nodoc
class _$ToastRequestCopyWithImpl<$Res>
    implements $ToastRequestCopyWith<$Res> {
  _$ToastRequestCopyWithImpl(this._self, this._then);

  final ToastRequest _self;
  final $Res Function(ToastRequest) _then;

/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = null,Object? message = null,Object? duration = freezed,Object? icon = freezed,Object? progress = freezed,Object? position = null,Object? primaryAction = freezed,Object? secondaryAction = freezed,Object? onDismissed = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ToastType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as Widget?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as ToastPosition,primaryAction: freezed == primaryAction ? _self.primaryAction : primaryAction // ignore: cast_nullable_to_non_nullable
as ToastAction?,secondaryAction: freezed == secondaryAction ? _self.secondaryAction : secondaryAction // ignore: cast_nullable_to_non_nullable
as ToastAction?,onDismissed: freezed == onDismissed ? _self.onDismissed : onDismissed // ignore: cast_nullable_to_non_nullable
as VoidCallback?,
  ));
}
/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToastActionCopyWith<$Res>? get primaryAction {
    if (_self.primaryAction == null) {
    return null;
  }

  return $ToastActionCopyWith<$Res>(_self.primaryAction!, (value) {
    return _then(_self.copyWith(primaryAction: value));
  });
}/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToastActionCopyWith<$Res>? get secondaryAction {
    if (_self.secondaryAction == null) {
    return null;
  }

  return $ToastActionCopyWith<$Res>(_self.secondaryAction!, (value) {
    return _then(_self.copyWith(secondaryAction: value));
  });
}
}


/// Adds pattern-matching-related methods to [ToastRequest].
extension ToastRequestPatterns on ToastRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToastRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToastRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToastRequest value)  $default,){
final _that = this;
switch (_that) {
case _ToastRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToastRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ToastRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  ToastType type,  String message,  Duration? duration,  Widget? icon,  double? progress,  ToastPosition position,  ToastAction? primaryAction,  ToastAction? secondaryAction,  VoidCallback? onDismissed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToastRequest() when $default != null:
return $default(_that.id,_that.type,_that.message,_that.duration,_that.icon,_that.progress,_that.position,_that.primaryAction,_that.secondaryAction,_that.onDismissed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  ToastType type,  String message,  Duration? duration,  Widget? icon,  double? progress,  ToastPosition position,  ToastAction? primaryAction,  ToastAction? secondaryAction,  VoidCallback? onDismissed)  $default,) {final _that = this;
switch (_that) {
case _ToastRequest():
return $default(_that.id,_that.type,_that.message,_that.duration,_that.icon,_that.progress,_that.position,_that.primaryAction,_that.secondaryAction,_that.onDismissed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  ToastType type,  String message,  Duration? duration,  Widget? icon,  double? progress,  ToastPosition position,  ToastAction? primaryAction,  ToastAction? secondaryAction,  VoidCallback? onDismissed)?  $default,) {final _that = this;
switch (_that) {
case _ToastRequest() when $default != null:
return $default(_that.id,_that.type,_that.message,_that.duration,_that.icon,_that.progress,_that.position,_that.primaryAction,_that.secondaryAction,_that.onDismissed);case _:
  return null;

}
}

}

/// @nodoc


class _ToastRequest implements ToastRequest {
  const _ToastRequest({this.id, this.type = ToastType.normal, required this.message, this.duration, this.icon, this.progress, this.position = ToastPosition.top, this.primaryAction, this.secondaryAction, this.onDismissed});
  

/// 唯一标识，用于进度更新或手动移除
@override final  String? id;
/// Toast 类型
@override@JsonKey() final  ToastType type;
/// 显示消息
@override final  String message;
/// 显示时长，null 则使用默认时长
@override final  Duration? duration;
/// 自定义图标
@override final  Widget? icon;
/// 进度值 (0.0 - 1.0), 仅 type == progress 有效
@override final  double? progress;
/// 显示位置
@override@JsonKey() final  ToastPosition position;
/// 主操作按钮
@override final  ToastAction? primaryAction;
/// 次要操作按钮
@override final  ToastAction? secondaryAction;
/// 消失时的回调
@override final  VoidCallback? onDismissed;

/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToastRequestCopyWith<_ToastRequest> get copyWith => __$ToastRequestCopyWithImpl<_ToastRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToastRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.position, position) || other.position == position)&&(identical(other.primaryAction, primaryAction) || other.primaryAction == primaryAction)&&(identical(other.secondaryAction, secondaryAction) || other.secondaryAction == secondaryAction)&&(identical(other.onDismissed, onDismissed) || other.onDismissed == onDismissed));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,message,duration,icon,progress,position,primaryAction,secondaryAction,onDismissed);

@override
String toString() {
  return 'ToastRequest(id: $id, type: $type, message: $message, duration: $duration, icon: $icon, progress: $progress, position: $position, primaryAction: $primaryAction, secondaryAction: $secondaryAction, onDismissed: $onDismissed)';
}


}

/// @nodoc
abstract mixin class _$ToastRequestCopyWith<$Res> implements $ToastRequestCopyWith<$Res> {
  factory _$ToastRequestCopyWith(_ToastRequest value, $Res Function(_ToastRequest) _then) = __$ToastRequestCopyWithImpl;
@override @useResult
$Res call({
 String? id, ToastType type, String message, Duration? duration, Widget? icon, double? progress, ToastPosition position, ToastAction? primaryAction, ToastAction? secondaryAction, VoidCallback? onDismissed
});


@override $ToastActionCopyWith<$Res>? get primaryAction;@override $ToastActionCopyWith<$Res>? get secondaryAction;

}
/// @nodoc
class __$ToastRequestCopyWithImpl<$Res>
    implements _$ToastRequestCopyWith<$Res> {
  __$ToastRequestCopyWithImpl(this._self, this._then);

  final _ToastRequest _self;
  final $Res Function(_ToastRequest) _then;

/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = null,Object? message = null,Object? duration = freezed,Object? icon = freezed,Object? progress = freezed,Object? position = null,Object? primaryAction = freezed,Object? secondaryAction = freezed,Object? onDismissed = freezed,}) {
  return _then(_ToastRequest(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ToastType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as Widget?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as ToastPosition,primaryAction: freezed == primaryAction ? _self.primaryAction : primaryAction // ignore: cast_nullable_to_non_nullable
as ToastAction?,secondaryAction: freezed == secondaryAction ? _self.secondaryAction : secondaryAction // ignore: cast_nullable_to_non_nullable
as ToastAction?,onDismissed: freezed == onDismissed ? _self.onDismissed : onDismissed // ignore: cast_nullable_to_non_nullable
as VoidCallback?,
  ));
}

/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToastActionCopyWith<$Res>? get primaryAction {
    if (_self.primaryAction == null) {
    return null;
  }

  return $ToastActionCopyWith<$Res>(_self.primaryAction!, (value) {
    return _then(_self.copyWith(primaryAction: value));
  });
}/// Create a copy of ToastRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToastActionCopyWith<$Res>? get secondaryAction {
    if (_self.secondaryAction == null) {
    return null;
  }

  return $ToastActionCopyWith<$Res>(_self.secondaryAction!, (value) {
    return _then(_self.copyWith(secondaryAction: value));
  });
}
}

/// @nodoc
mixin _$ToastState {

/// 当前显示的 Toast
 ToastRequest? get current;/// 等待队列
 List<ToastRequest> get queue;/// 进度任务状态映射 (id -> progress)
 Map<String, double> get progressMap;
/// Create a copy of ToastState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToastStateCopyWith<ToastState> get copyWith => _$ToastStateCopyWithImpl<ToastState>(this as ToastState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToastState&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.queue, queue)&&const DeepCollectionEquality().equals(other.progressMap, progressMap));
}


@override
int get hashCode => Object.hash(runtimeType,current,const DeepCollectionEquality().hash(queue),const DeepCollectionEquality().hash(progressMap));

@override
String toString() {
  return 'ToastState(current: $current, queue: $queue, progressMap: $progressMap)';
}


}

/// @nodoc
abstract mixin class $ToastStateCopyWith<$Res>  {
  factory $ToastStateCopyWith(ToastState value, $Res Function(ToastState) _then) = _$ToastStateCopyWithImpl;
@useResult
$Res call({
 ToastRequest? current, List<ToastRequest> queue, Map<String, double> progressMap
});


$ToastRequestCopyWith<$Res>? get current;

}
/// @nodoc
class _$ToastStateCopyWithImpl<$Res>
    implements $ToastStateCopyWith<$Res> {
  _$ToastStateCopyWithImpl(this._self, this._then);

  final ToastState _self;
  final $Res Function(ToastState) _then;

/// Create a copy of ToastState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = freezed,Object? queue = null,Object? progressMap = null,}) {
  return _then(_self.copyWith(
current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as ToastRequest?,queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<ToastRequest>,progressMap: null == progressMap ? _self.progressMap : progressMap // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}
/// Create a copy of ToastState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToastRequestCopyWith<$Res>? get current {
    if (_self.current == null) {
    return null;
  }

  return $ToastRequestCopyWith<$Res>(_self.current!, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}


/// Adds pattern-matching-related methods to [ToastState].
extension ToastStatePatterns on ToastState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToastState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToastState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToastState value)  $default,){
final _that = this;
switch (_that) {
case _ToastState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToastState value)?  $default,){
final _that = this;
switch (_that) {
case _ToastState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ToastRequest? current,  List<ToastRequest> queue,  Map<String, double> progressMap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToastState() when $default != null:
return $default(_that.current,_that.queue,_that.progressMap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ToastRequest? current,  List<ToastRequest> queue,  Map<String, double> progressMap)  $default,) {final _that = this;
switch (_that) {
case _ToastState():
return $default(_that.current,_that.queue,_that.progressMap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ToastRequest? current,  List<ToastRequest> queue,  Map<String, double> progressMap)?  $default,) {final _that = this;
switch (_that) {
case _ToastState() when $default != null:
return $default(_that.current,_that.queue,_that.progressMap);case _:
  return null;

}
}

}

/// @nodoc


class _ToastState implements ToastState {
  const _ToastState({this.current, final  List<ToastRequest> queue = const [], final  Map<String, double> progressMap = const {}}): _queue = queue,_progressMap = progressMap;
  

/// 当前显示的 Toast
@override final  ToastRequest? current;
/// 等待队列
 final  List<ToastRequest> _queue;
/// 等待队列
@override@JsonKey() List<ToastRequest> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}

/// 进度任务状态映射 (id -> progress)
 final  Map<String, double> _progressMap;
/// 进度任务状态映射 (id -> progress)
@override@JsonKey() Map<String, double> get progressMap {
  if (_progressMap is EqualUnmodifiableMapView) return _progressMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_progressMap);
}


/// Create a copy of ToastState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToastStateCopyWith<_ToastState> get copyWith => __$ToastStateCopyWithImpl<_ToastState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToastState&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._queue, _queue)&&const DeepCollectionEquality().equals(other._progressMap, _progressMap));
}


@override
int get hashCode => Object.hash(runtimeType,current,const DeepCollectionEquality().hash(_queue),const DeepCollectionEquality().hash(_progressMap));

@override
String toString() {
  return 'ToastState(current: $current, queue: $queue, progressMap: $progressMap)';
}


}

/// @nodoc
abstract mixin class _$ToastStateCopyWith<$Res> implements $ToastStateCopyWith<$Res> {
  factory _$ToastStateCopyWith(_ToastState value, $Res Function(_ToastState) _then) = __$ToastStateCopyWithImpl;
@override @useResult
$Res call({
 ToastRequest? current, List<ToastRequest> queue, Map<String, double> progressMap
});


@override $ToastRequestCopyWith<$Res>? get current;

}
/// @nodoc
class __$ToastStateCopyWithImpl<$Res>
    implements _$ToastStateCopyWith<$Res> {
  __$ToastStateCopyWithImpl(this._self, this._then);

  final _ToastState _self;
  final $Res Function(_ToastState) _then;

/// Create a copy of ToastState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = freezed,Object? queue = null,Object? progressMap = null,}) {
  return _then(_ToastState(
current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as ToastRequest?,queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<ToastRequest>,progressMap: null == progressMap ? _self._progressMap : progressMap // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

/// Create a copy of ToastState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToastRequestCopyWith<$Res>? get current {
    if (_self.current == null) {
    return null;
  }

  return $ToastRequestCopyWith<$Res>(_self.current!, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}

// dart format on
