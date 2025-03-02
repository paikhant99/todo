
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/data/entity/task.dart';

part 'goal.freezed.dart';

part 'goal.g.dart';

@unfreezed
class Goal with _$Goal {
  factory Goal(
      {@JsonKey(name: "id") @Default(null) int? goalId,
      @JsonKey(name: "goal_name") required String goalName,
      @JsonKey(name: "all_tasks_count") required int allTasksCount,
      @JsonKey(name: "completed_tasks_count") required int completedTasksCount}) = _Goal;

  factory Goal.fromJson(Map<String, Object?> json) => _$GoalFromJson(json);
}