import 'package:festival_app/model/task.dart';
import 'package:json_annotation/json_annotation.dart';

part 'festical_card.g.dart'; // 生成的代码会存放在此文

@JsonSerializable(explicitToJson: true)
class FestivalCardModel {
  final String festivalName;
  final DateTime data;
  final String imageUrl;
  final int plans;
  final String festivalState;
  final List<TaskItem> taskItem;

  FestivalCardModel(
      {required this.festivalName,
      required this.data,
      required this.imageUrl,
      required this.festivalState,
      required this.plans,
      required this.taskItem});

  factory FestivalCardModel.fromJson(Map<String, dynamic> json) =>
      _$FestivalCardModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FestivalCardModelToJson(this);
}
