// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      taskId: (json['id'] as num?)?.toInt(),
      taskDesc: json['task_desc'] as String,
      taskDate: json['task_date'] as String,
      taskStartTime: json['start_time'] as String?,
      taskEndTime: json['end_time'] as String?,
      isCompleted: (json['completed'] as num).toInt(),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.taskId,
      'task_desc': instance.taskDesc,
      'task_date': instance.taskDate,
      'start_time': instance.taskStartTime,
      'end_time': instance.taskEndTime,
      'completed': instance.isCompleted,
    };
