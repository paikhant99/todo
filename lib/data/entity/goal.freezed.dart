// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  @JsonKey(name: "id")
  int? get goalId => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set goalId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "goal_name")
  String get goalName => throw _privateConstructorUsedError;
  @JsonKey(name: "goal_name")
  set goalName(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: "tasks")
  List<Task> get tasks => throw _privateConstructorUsedError;
  @JsonKey(name: "tasks")
  set tasks(List<Task> value) => throw _privateConstructorUsedError;

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? goalId,
      @JsonKey(name: "goal_name") String goalName,
      @JsonKey(name: "tasks") List<Task> tasks});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = freezed,
    Object? goalName = null,
    Object? tasks = null,
  }) {
    return _then(_value.copyWith(
      goalId: freezed == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as int?,
      goalName: null == goalName
          ? _value.goalName
          : goalName // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? goalId,
      @JsonKey(name: "goal_name") String goalName,
      @JsonKey(name: "tasks") List<Task> tasks});
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goalId = freezed,
    Object? goalName = null,
    Object? tasks = null,
  }) {
    return _then(_$GoalImpl(
      goalId: freezed == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as int?,
      goalName: null == goalName
          ? _value.goalName
          : goalName // ignore: cast_nullable_to_non_nullable
              as String,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalImpl implements _Goal {
  _$GoalImpl(
      {@JsonKey(name: "id") this.goalId = null,
      @JsonKey(name: "goal_name") required this.goalName,
      @JsonKey(name: "tasks") this.tasks = const []});

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  @override
  @JsonKey(name: "id")
  int? goalId;
  @override
  @JsonKey(name: "goal_name")
  String goalName;
  @override
  @JsonKey(name: "tasks")
  List<Task> tasks;

  @override
  String toString() {
    return 'Goal(goalId: $goalId, goalName: $goalName, tasks: $tasks)';
  }

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  factory _Goal(
      {@JsonKey(name: "id") int? goalId,
      @JsonKey(name: "goal_name") required String goalName,
      @JsonKey(name: "tasks") List<Task> tasks}) = _$GoalImpl;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get goalId;
  @JsonKey(name: "id")
  set goalId(int? value);
  @override
  @JsonKey(name: "goal_name")
  String get goalName;
  @JsonKey(name: "goal_name")
  set goalName(String value);
  @override
  @JsonKey(name: "tasks")
  List<Task> get tasks;
  @JsonKey(name: "tasks")
  set tasks(List<Task> value);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
