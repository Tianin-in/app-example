import 'package:festival_app/components/custom_date_picker.dart';
import 'package:festival_app/model/festival_and_task.dart';
import 'package:festival_app/components/edit_festival_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class TaskDialog extends HookConsumerWidget {
  const TaskDialog({
    super.key,
    required this.festival,
    required this.onSave,
  });

  final FestivalAndTasks festival;
  final void Function(FestivalAndTasks) onSave;

  void _toggleTaskStatus(BuildContext context, TaskItem task) {
    final updatedTasks = festival.taskItem.map((t) {
      if (t.id == task.id) {
        return t.copyWith(isCompleted: !t.isCompleted);
      }
      return t;
    }).toList();

    final updatedFestival = festival.copyWith(taskItem: updatedTasks);
    onSave(updatedFestival);

    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => TaskDialog(
        festival: updatedFestival,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFlipped = useState(false);
    final isTaskItemTapped = useState(false);

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: GestureDetector(
        onDoubleTap: () {
          if (!isTaskItemTapped.value) {
            isFlipped.value = !isFlipped.value;
          }
          isTaskItemTapped.value = false;
        },
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 700),
          tween: Tween<double>(
            begin: isFlipped.value ? 0 : 180,
            end: isFlipped.value ? 180 : 0,
          ),
          builder: (context, double value, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(value * 3.1415927 / 180),
              child: value >= 90
                  ? Container(
                      width: MediaQuery.of(context).size.height * 0.9,
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/OIP.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.height * 0.9,
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 15.h),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('yyyy/MM/dd')
                                                  .format(festival.data),
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    TextField(
                                      controller: TextEditingController(
                                          text: festival.festivalName),
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: '节日名称',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      "任务列表",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: festival.taskItem
                                          .where((task) => !task.isCompleted)
                                          .length,
                                      itemBuilder: (context, index) {
                                        final task = festival.taskItem
                                            .where((task) => !task.isCompleted)
                                            .toList()[index];
                                        return GestureDetector(
                                          onDoubleTap: () {
                                            isTaskItemTapped.value = true;
                                            _toggleTaskStatus(context, task);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 12.w,
                                                  height: 12.h,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Text(
                                                    task.content,
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    if (festival.taskItem
                                        .any((task) => task.isCompleted)) ...[
                                      SizedBox(height: 20.h),
                                      Text(
                                        "已完成",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: festival.taskItem
                                            .where((task) => task.isCompleted)
                                            .length,
                                        itemBuilder: (context, index) {
                                          final task = festival.taskItem
                                              .where((task) => task.isCompleted)
                                              .toList()[index];
                                          return GestureDetector(
                                            onDoubleTap: () {
                                              isTaskItemTapped.value = true;
                                              _toggleTaskStatus(context, task);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 12.w,
                                                    height: 12.h,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Expanded(
                                                    child: Text(
                                                      task.content,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (!isFlipped.value)
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      '退出',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (context) => EditFestivalPage(
                                          festival: festival,
                                          onSave: onSave,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '编辑',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
