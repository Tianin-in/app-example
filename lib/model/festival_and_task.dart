import 'package:festival_app/providers/festival_and_tasks_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'festival_and_task.g.dart';
part 'festival_and_task.freezed.dart';

@freezed
class FestivalAndTasks with _$FestivalAndTasks {
  const factory FestivalAndTasks({
    required String id, //节日名称
    required String festivalName, //节日名称
    required DateTime data, //日期
    required String imageUrl, //背景图片
    required int plans, //计划数
    required FestivalFilter dayType, //日期类型 ：阳历 阴历 国家法定 自定义
    required int countDown, //倒计时多少天
    required String state, //状态
    required String festivalDescription, // 节日描述
    required List<TaskItem> taskItem, //任务列表
  }) = _FestivalAndTasks;

  factory FestivalAndTasks.fromJson(Map<String, dynamic> json) =>
      _$FestivalAndTasksFromJson(json);
}

@freezed
class TaskItem with _$TaskItem {
  const factory TaskItem({
    required String id,
    required String content,
    @Default(false) bool isCompleted,
    @Default(false) bool isEditing,
  }) = _TaskItem;

  factory TaskItem.fromJson(Map<String, dynamic> json) =>
      _$TaskItemFromJson(json);
}
