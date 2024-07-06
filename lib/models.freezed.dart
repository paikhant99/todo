// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  @JsonKey(name: "id")
  int? get taskId => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set taskId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "task_desc")
  String get taskDesc => throw _privateConstructorUsedError;
  @JsonKey(name: "task_desc")
  set taskDesc(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "reminder_date")
  String get taskDate => throw _privateConstructorUsedError;
  @JsonKey(name: "reminder_date")
  set taskDate(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "reminder_time")
  String? get taskTime => throw _privateConstructorUsedError;
  @JsonKey(name: "reminder_time")
  set taskTime(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "completed")
  int get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: "completed")
  set isCompleted(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? taskId,
      @JsonKey(name: "task_desc") String taskDesc,
      @JsonKey(name: "reminder_date") String taskDate,
      @JsonKey(name: "reminder_time") String? taskTime,
      @JsonKey(name: "completed") int isCompleted});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = freezed,
    Object? taskDesc = null,
    Object? taskDate = null,
    Object? taskTime = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as int?,
      taskDesc: null == taskDesc
          ? _value.taskDesc
          : taskDesc // ignore: cast_nullable_to_non_nullable
              as String,
      taskDate: null == taskDate
          ? _value.taskDate
          : taskDate // ignore: cast_nullable_to_non_nullable
              as String,
      taskTime: freezed == taskTime
          ? _value.taskTime
          : taskTime // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? taskId,
      @JsonKey(name: "task_desc") String taskDesc,
      @JsonKey(name: "reminder_date") String taskDate,
      @JsonKey(name: "reminder_time") String? taskTime,
      @JsonKey(name: "completed") int isCompleted});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = freezed,
    Object? taskDesc = null,
    Object? taskDate = null,
    Object? taskTime = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_$TaskImpl(
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as int?,
      taskDesc: null == taskDesc
          ? _value.taskDesc
          : taskDesc // ignore: cast_nullable_to_non_nullable
              as String,
      taskDate: null == taskDate
          ? _value.taskDate
          : taskDate // ignore: cast_nullable_to_non_nullable
              as String,
      taskTime: freezed == taskTime
          ? _value.taskTime
          : taskTime // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl with DiagnosticableTreeMixin implements _Task {
  _$TaskImpl(
      {@JsonKey(name: "id") required this.taskId,
      @JsonKey(name: "task_desc") required this.taskDesc,
      @JsonKey(name: "reminder_date") required this.taskDate,
      @JsonKey(name: "reminder_time") required this.taskTime,
      @JsonKey(name: "completed") required this.isCompleted});

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? taskId;
  @override
  @JsonKey(name: "task_desc")
  String taskDesc;
  @override
  @JsonKey(name: "reminder_date")
  String taskDate;
  @override
  @JsonKey(name: "reminder_time")
  String? taskTime;
  @override
  @JsonKey(name: "completed")
  int isCompleted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Task(taskId: $taskId, taskDesc: $taskDesc, taskDate: $taskDate, taskTime: $taskTime, isCompleted: $isCompleted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Task'))
      ..add(DiagnosticsProperty('taskId', taskId))
      ..add(DiagnosticsProperty('taskDesc', taskDesc))
      ..add(DiagnosticsProperty('taskDate', taskDate))
      ..add(DiagnosticsProperty('taskTime', taskTime))
      ..add(DiagnosticsProperty('isCompleted', isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  factory _Task(
      {@JsonKey(name: "id") required int? taskId,
      @JsonKey(name: "task_desc") required String taskDesc,
      @JsonKey(name: "reminder_date") required String taskDate,
      @JsonKey(name: "reminder_time") required String? taskTime,
      @JsonKey(name: "completed") required int isCompleted}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get taskId;
  @JsonKey(name: "id")
  set taskId(int? value);
  @override
  @JsonKey(name: "task_desc")
  String get taskDesc;
  @JsonKey(name: "task_desc")
  set taskDesc(String value);
  @override
  @JsonKey(name: "reminder_date")
  String get taskDate;
  @JsonKey(name: "reminder_date")
  set taskDate(String value);
  @override
  @JsonKey(name: "reminder_time")
  String? get taskTime;
  @JsonKey(name: "reminder_time")
  set taskTime(String? value);
  @override
  @JsonKey(name: "completed")
  int get isCompleted;
  @JsonKey(name: "completed")
  set isCompleted(int value);
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
