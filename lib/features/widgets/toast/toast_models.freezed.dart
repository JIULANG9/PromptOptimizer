// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toast_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ToastAction {
  String get label => throw _privateConstructorUsedError;
  VoidCallback get onPressed => throw _privateConstructorUsedError;

  /// Create a copy of ToastAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToastActionCopyWith<ToastAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToastActionCopyWith<$Res> {
  factory $ToastActionCopyWith(
    ToastAction value,
    $Res Function(ToastAction) then,
  ) = _$ToastActionCopyWithImpl<$Res, ToastAction>;
  @useResult
  $Res call({String label, VoidCallback onPressed});
}

/// @nodoc
class _$ToastActionCopyWithImpl<$Res, $Val extends ToastAction>
    implements $ToastActionCopyWith<$Res> {
  _$ToastActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToastAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? onPressed = null}) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            onPressed: null == onPressed
                ? _value.onPressed
                : onPressed // ignore: cast_nullable_to_non_nullable
                      as VoidCallback,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ToastActionImplCopyWith<$Res>
    implements $ToastActionCopyWith<$Res> {
  factory _$$ToastActionImplCopyWith(
    _$ToastActionImpl value,
    $Res Function(_$ToastActionImpl) then,
  ) = __$$ToastActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, VoidCallback onPressed});
}

/// @nodoc
class __$$ToastActionImplCopyWithImpl<$Res>
    extends _$ToastActionCopyWithImpl<$Res, _$ToastActionImpl>
    implements _$$ToastActionImplCopyWith<$Res> {
  __$$ToastActionImplCopyWithImpl(
    _$ToastActionImpl _value,
    $Res Function(_$ToastActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ToastAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? onPressed = null}) {
    return _then(
      _$ToastActionImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        onPressed: null == onPressed
            ? _value.onPressed
            : onPressed // ignore: cast_nullable_to_non_nullable
                  as VoidCallback,
      ),
    );
  }
}

/// @nodoc

class _$ToastActionImpl implements _ToastAction {
  const _$ToastActionImpl({required this.label, required this.onPressed});

  @override
  final String label;
  @override
  final VoidCallback onPressed;

  @override
  String toString() {
    return 'ToastAction(label: $label, onPressed: $onPressed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastActionImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.onPressed, onPressed) ||
                other.onPressed == onPressed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, onPressed);

  /// Create a copy of ToastAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastActionImplCopyWith<_$ToastActionImpl> get copyWith =>
      __$$ToastActionImplCopyWithImpl<_$ToastActionImpl>(this, _$identity);
}

abstract class _ToastAction implements ToastAction {
  const factory _ToastAction({
    required final String label,
    required final VoidCallback onPressed,
  }) = _$ToastActionImpl;

  @override
  String get label;
  @override
  VoidCallback get onPressed;

  /// Create a copy of ToastAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastActionImplCopyWith<_$ToastActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ToastRequest {
  /// 唯一标识，用于进度更新或手动移除
  String? get id => throw _privateConstructorUsedError;

  /// Toast 类型
  ToastType get type => throw _privateConstructorUsedError;

  /// 显示消息
  String get message => throw _privateConstructorUsedError;

  /// 显示时长，null 则使用默认时长
  Duration? get duration => throw _privateConstructorUsedError;

  /// 自定义图标
  Widget? get icon => throw _privateConstructorUsedError;

  /// 进度值 (0.0 - 1.0), 仅 type == progress 有效
  double? get progress => throw _privateConstructorUsedError;

  /// 显示位置
  ToastPosition get position => throw _privateConstructorUsedError;

  /// 主操作按钮
  ToastAction? get primaryAction => throw _privateConstructorUsedError;

  /// 次要操作按钮
  ToastAction? get secondaryAction => throw _privateConstructorUsedError;

  /// 消失时的回调
  VoidCallback? get onDismissed => throw _privateConstructorUsedError;

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToastRequestCopyWith<ToastRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToastRequestCopyWith<$Res> {
  factory $ToastRequestCopyWith(
    ToastRequest value,
    $Res Function(ToastRequest) then,
  ) = _$ToastRequestCopyWithImpl<$Res, ToastRequest>;
  @useResult
  $Res call({
    String? id,
    ToastType type,
    String message,
    Duration? duration,
    Widget? icon,
    double? progress,
    ToastPosition position,
    ToastAction? primaryAction,
    ToastAction? secondaryAction,
    VoidCallback? onDismissed,
  });

  $ToastActionCopyWith<$Res>? get primaryAction;
  $ToastActionCopyWith<$Res>? get secondaryAction;
}

/// @nodoc
class _$ToastRequestCopyWithImpl<$Res, $Val extends ToastRequest>
    implements $ToastRequestCopyWith<$Res> {
  _$ToastRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? message = null,
    Object? duration = freezed,
    Object? icon = freezed,
    Object? progress = freezed,
    Object? position = null,
    Object? primaryAction = freezed,
    Object? secondaryAction = freezed,
    Object? onDismissed = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ToastType,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as Widget?,
            progress: freezed == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double?,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as ToastPosition,
            primaryAction: freezed == primaryAction
                ? _value.primaryAction
                : primaryAction // ignore: cast_nullable_to_non_nullable
                      as ToastAction?,
            secondaryAction: freezed == secondaryAction
                ? _value.secondaryAction
                : secondaryAction // ignore: cast_nullable_to_non_nullable
                      as ToastAction?,
            onDismissed: freezed == onDismissed
                ? _value.onDismissed
                : onDismissed // ignore: cast_nullable_to_non_nullable
                      as VoidCallback?,
          )
          as $Val,
    );
  }

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastActionCopyWith<$Res>? get primaryAction {
    if (_value.primaryAction == null) {
      return null;
    }

    return $ToastActionCopyWith<$Res>(_value.primaryAction!, (value) {
      return _then(_value.copyWith(primaryAction: value) as $Val);
    });
  }

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastActionCopyWith<$Res>? get secondaryAction {
    if (_value.secondaryAction == null) {
      return null;
    }

    return $ToastActionCopyWith<$Res>(_value.secondaryAction!, (value) {
      return _then(_value.copyWith(secondaryAction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ToastRequestImplCopyWith<$Res>
    implements $ToastRequestCopyWith<$Res> {
  factory _$$ToastRequestImplCopyWith(
    _$ToastRequestImpl value,
    $Res Function(_$ToastRequestImpl) then,
  ) = __$$ToastRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    ToastType type,
    String message,
    Duration? duration,
    Widget? icon,
    double? progress,
    ToastPosition position,
    ToastAction? primaryAction,
    ToastAction? secondaryAction,
    VoidCallback? onDismissed,
  });

  @override
  $ToastActionCopyWith<$Res>? get primaryAction;
  @override
  $ToastActionCopyWith<$Res>? get secondaryAction;
}

/// @nodoc
class __$$ToastRequestImplCopyWithImpl<$Res>
    extends _$ToastRequestCopyWithImpl<$Res, _$ToastRequestImpl>
    implements _$$ToastRequestImplCopyWith<$Res> {
  __$$ToastRequestImplCopyWithImpl(
    _$ToastRequestImpl _value,
    $Res Function(_$ToastRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = null,
    Object? message = null,
    Object? duration = freezed,
    Object? icon = freezed,
    Object? progress = freezed,
    Object? position = null,
    Object? primaryAction = freezed,
    Object? secondaryAction = freezed,
    Object? onDismissed = freezed,
  }) {
    return _then(
      _$ToastRequestImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ToastType,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as Widget?,
        progress: freezed == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double?,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as ToastPosition,
        primaryAction: freezed == primaryAction
            ? _value.primaryAction
            : primaryAction // ignore: cast_nullable_to_non_nullable
                  as ToastAction?,
        secondaryAction: freezed == secondaryAction
            ? _value.secondaryAction
            : secondaryAction // ignore: cast_nullable_to_non_nullable
                  as ToastAction?,
        onDismissed: freezed == onDismissed
            ? _value.onDismissed
            : onDismissed // ignore: cast_nullable_to_non_nullable
                  as VoidCallback?,
      ),
    );
  }
}

/// @nodoc

class _$ToastRequestImpl implements _ToastRequest {
  const _$ToastRequestImpl({
    this.id,
    this.type = ToastType.normal,
    required this.message,
    this.duration,
    this.icon,
    this.progress,
    this.position = ToastPosition.top,
    this.primaryAction,
    this.secondaryAction,
    this.onDismissed,
  });

  /// 唯一标识，用于进度更新或手动移除
  @override
  final String? id;

  /// Toast 类型
  @override
  @JsonKey()
  final ToastType type;

  /// 显示消息
  @override
  final String message;

  /// 显示时长，null 则使用默认时长
  @override
  final Duration? duration;

  /// 自定义图标
  @override
  final Widget? icon;

  /// 进度值 (0.0 - 1.0), 仅 type == progress 有效
  @override
  final double? progress;

  /// 显示位置
  @override
  @JsonKey()
  final ToastPosition position;

  /// 主操作按钮
  @override
  final ToastAction? primaryAction;

  /// 次要操作按钮
  @override
  final ToastAction? secondaryAction;

  /// 消失时的回调
  @override
  final VoidCallback? onDismissed;

  @override
  String toString() {
    return 'ToastRequest(id: $id, type: $type, message: $message, duration: $duration, icon: $icon, progress: $progress, position: $position, primaryAction: $primaryAction, secondaryAction: $secondaryAction, onDismissed: $onDismissed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.primaryAction, primaryAction) ||
                other.primaryAction == primaryAction) &&
            (identical(other.secondaryAction, secondaryAction) ||
                other.secondaryAction == secondaryAction) &&
            (identical(other.onDismissed, onDismissed) ||
                other.onDismissed == onDismissed));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    message,
    duration,
    icon,
    progress,
    position,
    primaryAction,
    secondaryAction,
    onDismissed,
  );

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastRequestImplCopyWith<_$ToastRequestImpl> get copyWith =>
      __$$ToastRequestImplCopyWithImpl<_$ToastRequestImpl>(this, _$identity);
}

abstract class _ToastRequest implements ToastRequest {
  const factory _ToastRequest({
    final String? id,
    final ToastType type,
    required final String message,
    final Duration? duration,
    final Widget? icon,
    final double? progress,
    final ToastPosition position,
    final ToastAction? primaryAction,
    final ToastAction? secondaryAction,
    final VoidCallback? onDismissed,
  }) = _$ToastRequestImpl;

  /// 唯一标识，用于进度更新或手动移除
  @override
  String? get id;

  /// Toast 类型
  @override
  ToastType get type;

  /// 显示消息
  @override
  String get message;

  /// 显示时长，null 则使用默认时长
  @override
  Duration? get duration;

  /// 自定义图标
  @override
  Widget? get icon;

  /// 进度值 (0.0 - 1.0), 仅 type == progress 有效
  @override
  double? get progress;

  /// 显示位置
  @override
  ToastPosition get position;

  /// 主操作按钮
  @override
  ToastAction? get primaryAction;

  /// 次要操作按钮
  @override
  ToastAction? get secondaryAction;

  /// 消失时的回调
  @override
  VoidCallback? get onDismissed;

  /// Create a copy of ToastRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastRequestImplCopyWith<_$ToastRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ToastState {
  /// 当前显示的 Toast
  ToastRequest? get current => throw _privateConstructorUsedError;

  /// 等待队列
  List<ToastRequest> get queue => throw _privateConstructorUsedError;

  /// 进度任务状态映射 (id -> progress)
  Map<String, double> get progressMap => throw _privateConstructorUsedError;

  /// Create a copy of ToastState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToastStateCopyWith<ToastState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToastStateCopyWith<$Res> {
  factory $ToastStateCopyWith(
    ToastState value,
    $Res Function(ToastState) then,
  ) = _$ToastStateCopyWithImpl<$Res, ToastState>;
  @useResult
  $Res call({
    ToastRequest? current,
    List<ToastRequest> queue,
    Map<String, double> progressMap,
  });

  $ToastRequestCopyWith<$Res>? get current;
}

/// @nodoc
class _$ToastStateCopyWithImpl<$Res, $Val extends ToastState>
    implements $ToastStateCopyWith<$Res> {
  _$ToastStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToastState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = freezed,
    Object? queue = null,
    Object? progressMap = null,
  }) {
    return _then(
      _value.copyWith(
            current: freezed == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                      as ToastRequest?,
            queue: null == queue
                ? _value.queue
                : queue // ignore: cast_nullable_to_non_nullable
                      as List<ToastRequest>,
            progressMap: null == progressMap
                ? _value.progressMap
                : progressMap // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
          )
          as $Val,
    );
  }

  /// Create a copy of ToastState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ToastRequestCopyWith<$Res>? get current {
    if (_value.current == null) {
      return null;
    }

    return $ToastRequestCopyWith<$Res>(_value.current!, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ToastStateImplCopyWith<$Res>
    implements $ToastStateCopyWith<$Res> {
  factory _$$ToastStateImplCopyWith(
    _$ToastStateImpl value,
    $Res Function(_$ToastStateImpl) then,
  ) = __$$ToastStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ToastRequest? current,
    List<ToastRequest> queue,
    Map<String, double> progressMap,
  });

  @override
  $ToastRequestCopyWith<$Res>? get current;
}

/// @nodoc
class __$$ToastStateImplCopyWithImpl<$Res>
    extends _$ToastStateCopyWithImpl<$Res, _$ToastStateImpl>
    implements _$$ToastStateImplCopyWith<$Res> {
  __$$ToastStateImplCopyWithImpl(
    _$ToastStateImpl _value,
    $Res Function(_$ToastStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ToastState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current = freezed,
    Object? queue = null,
    Object? progressMap = null,
  }) {
    return _then(
      _$ToastStateImpl(
        current: freezed == current
            ? _value.current
            : current // ignore: cast_nullable_to_non_nullable
                  as ToastRequest?,
        queue: null == queue
            ? _value._queue
            : queue // ignore: cast_nullable_to_non_nullable
                  as List<ToastRequest>,
        progressMap: null == progressMap
            ? _value._progressMap
            : progressMap // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
      ),
    );
  }
}

/// @nodoc

class _$ToastStateImpl implements _ToastState {
  const _$ToastStateImpl({
    this.current,
    final List<ToastRequest> queue = const [],
    final Map<String, double> progressMap = const {},
  }) : _queue = queue,
       _progressMap = progressMap;

  /// 当前显示的 Toast
  @override
  final ToastRequest? current;

  /// 等待队列
  final List<ToastRequest> _queue;

  /// 等待队列
  @override
  @JsonKey()
  List<ToastRequest> get queue {
    if (_queue is EqualUnmodifiableListView) return _queue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queue);
  }

  /// 进度任务状态映射 (id -> progress)
  final Map<String, double> _progressMap;

  /// 进度任务状态映射 (id -> progress)
  @override
  @JsonKey()
  Map<String, double> get progressMap {
    if (_progressMap is EqualUnmodifiableMapView) return _progressMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_progressMap);
  }

  @override
  String toString() {
    return 'ToastState(current: $current, queue: $queue, progressMap: $progressMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToastStateImpl &&
            (identical(other.current, current) || other.current == current) &&
            const DeepCollectionEquality().equals(other._queue, _queue) &&
            const DeepCollectionEquality().equals(
              other._progressMap,
              _progressMap,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    current,
    const DeepCollectionEquality().hash(_queue),
    const DeepCollectionEquality().hash(_progressMap),
  );

  /// Create a copy of ToastState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToastStateImplCopyWith<_$ToastStateImpl> get copyWith =>
      __$$ToastStateImplCopyWithImpl<_$ToastStateImpl>(this, _$identity);
}

abstract class _ToastState implements ToastState {
  const factory _ToastState({
    final ToastRequest? current,
    final List<ToastRequest> queue,
    final Map<String, double> progressMap,
  }) = _$ToastStateImpl;

  /// 当前显示的 Toast
  @override
  ToastRequest? get current;

  /// 等待队列
  @override
  List<ToastRequest> get queue;

  /// 进度任务状态映射 (id -> progress)
  @override
  Map<String, double> get progressMap;

  /// Create a copy of ToastState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToastStateImplCopyWith<_$ToastStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
