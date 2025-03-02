// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      goalId: (json['id'] as num?)?.toInt() ?? null,
      goalName: json['goal_name'] as String,
      allTasksCount: (json['all_tasks_count'] as num).toInt(),
      completedTasksCount: (json['completed_tasks_count'] as num).toInt(),
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'id': instance.goalId,
      'goal_name': instance.goalName,
      'all_tasks_count': instance.allTasksCount,
      'completed_tasks_count': instance.completedTasksCount,
    };
