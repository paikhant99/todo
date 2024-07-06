// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      taskId: (json['id'] as num?)?.toInt(),
      taskDesc: json['task_desc'] as String,
      taskDate: json['reminder_date'] as String,
      taskTime: json['reminder_time'] as String?,
      isCompleted: (json['completed'] as num).toInt(),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.taskId,
      'task_desc': instance.taskDesc,
      'reminder_date': instance.taskDate,
      'reminder_time': instance.taskTime,
      'completed': instance.isCompleted,
    };
