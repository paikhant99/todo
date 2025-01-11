// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      taskId: (json['id'] as num?)?.toInt(),
      taskName: json['task_name'] as String,
      goalName: json['goal_name'] as String,
      description: json['desc'] as String,
      taskTime: json['task_time'] as String?,
      isCompleted: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.taskId,
      'task_name': instance.taskName,
      'goal_name': instance.goalName,
      'desc': instance.description,
      'task_time': instance.taskTime,
      'completed': instance.isCompleted,
    };
