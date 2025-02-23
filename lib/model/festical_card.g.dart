// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festical_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FestivalCardModel _$FestivalCardModelFromJson(Map<String, dynamic> json) =>
    FestivalCardModel(
      festivalName: json['festivalName'] as String,
      data: DateTime.parse(json['data'] as String),
      imageUrl: json['imageUrl'] as String,
      festivalState: json['festivalState'] as String,
      plans: (json['plans'] as num).toInt(),
      taskItem: (json['taskItem'] as List<dynamic>)
          .map((e) => TaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FestivalCardModelToJson(FestivalCardModel instance) =>
    <String, dynamic>{
      'festivalName': instance.festivalName,
      'data': instance.data.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'plans': instance.plans,
      'festivalState': instance.festivalState,
      'taskItem': instance.taskItem.map((e) => e.toJson()).toList(),
    };
