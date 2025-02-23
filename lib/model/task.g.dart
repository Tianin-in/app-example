// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) => TaskItem(
      id: json['id'] as String,
      content: json['content'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$TaskItemToJson(TaskItem instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isCompleted': instance.isCompleted,
    };
