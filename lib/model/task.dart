import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart'; // 生成的代码会存放在此文件中

@JsonSerializable(explicitToJson: true)
class TaskItem {
  String id;
  String content;
  bool isCompleted;

  TaskItem({
    required this.id,
    required this.content,
    required this.isCompleted,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);
}
