// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_and_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FestivalAndTasksImpl _$$FestivalAndTasksImplFromJson(
        Map<String, dynamic> json) =>
    _$FestivalAndTasksImpl(
      id: json['id'] as String,
      festivalName: json['festivalName'] as String,
      data: DateTime.parse(json['data'] as String),
      imageUrl: json['imageUrl'] as String,
      plans: (json['plans'] as num).toInt(),
      dayType: $enumDecode(_$FestivalFilterEnumMap, json['dayType']),
      countDown: (json['countDown'] as num).toInt(),
      state: json['state'] as String,
      festivalDescription: json['festivalDescription'] as String,
      taskItem: (json['taskItem'] as List<dynamic>)
          .map((e) => TaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FestivalAndTasksImplToJson(
        _$FestivalAndTasksImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'festivalName': instance.festivalName,
      'data': instance.data.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'plans': instance.plans,
      'dayType': _$FestivalFilterEnumMap[instance.dayType]!,
      'countDown': instance.countDown,
      'state': instance.state,
      'festivalDescription': instance.festivalDescription,
      'taskItem': instance.taskItem,
    };

const _$FestivalFilterEnumMap = {
  FestivalFilter.all: 'all',
  FestivalFilter.official: 'official',
  FestivalFilter.custom: 'custom',
};

_$TaskItemImpl _$$TaskItemImplFromJson(Map<String, dynamic> json) =>
    _$TaskItemImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isEditing: json['isEditing'] as bool? ?? false,
    );

Map<String, dynamic> _$$TaskItemImplToJson(_$TaskItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isCompleted': instance.isCompleted,
      'isEditing': instance.isEditing,
    };
