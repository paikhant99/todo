import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@unfreezed
class Task with _$Task {
  factory Task(
      {@JsonKey(name: "id") required int? taskId,
      @JsonKey(name: "task_desc") required String taskDesc,
      @JsonKey(name: "reminder_date") required String taskDate,
      @JsonKey(name: "reminder_time") required String? taskTime,
      @JsonKey(name: "completed") required int isCompleted}) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}
