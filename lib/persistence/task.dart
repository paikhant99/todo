import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@unfreezed
class Task with _$Task {
  factory Task(
      {@JsonKey(name: "id") required int? taskId,
      @JsonKey(name: "task_name") required String taskName,
      @JsonKey(name: "goal_name") required String goalName,
      @JsonKey(name: "desc") required String description,
      @JsonKey(name: "task_time") required String? taskTime,
      @JsonKey(name: "completed") @Default(false) bool isCompleted}) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}
