import 'package:festival_app/components/custom_date_picker.dart';
import 'package:festival_app/components/task_dialog.dart';
import 'package:festival_app/model/festival_and_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EditFestivalPage extends StatefulWidget {
  final FestivalAndTasks festival;
  final Function(FestivalAndTasks) onSave;

  const EditFestivalPage({
    Key? key,
    required this.festival,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditFestivalPage> createState() => _EditFestivalPageState();
}

class _EditFestivalPageState extends State<EditFestivalPage> {
  late TextEditingController nameController;
  late TextEditingController newTaskController;
  late FocusNode newTaskFocus;
  late List<TaskItem> taskItems;
  final Map<String, bool> _editingStates = {};
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.festival.festivalName);
    newTaskController = TextEditingController();
    newTaskFocus = FocusNode();
    newTaskFocus.addListener(_handleFocusChange);
    taskItems = List.from(widget.festival.taskItem);
    currentDate = widget.festival.data;
  }

  @override
  void dispose() {
    nameController.dispose();
    newTaskController.dispose();
    newTaskFocus.removeListener(_handleFocusChange);
    newTaskFocus.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!newTaskFocus.hasFocus && newTaskController.text.trim().isNotEmpty) {
      setState(() {
        taskItems.add(TaskItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: newTaskController.text.trim(),
          isCompleted: false,
        ));
        newTaskController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  void _showDatePicker(BuildContext context, WidgetRef ref) {
    // final currentDateParts =
    //     currentDate.replaceAll('月', '-').replaceAll('日', '').split('-');
    // final initialDate = DateTime(
    //   DateTime.now().year,
    //   int.parse(currentDateParts[0]),
    //   int.parse(currentDateParts[1]),
    // );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: CustomDatePicker(
          initialDate: currentDate,
          onDateSelected: (date) {
            setState(() {
              currentDate = date;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('yyyy MM-dd').format(currentDate),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  return GestureDetector(
                                    onTap: () => _showDatePicker(context, ref),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: '节日名称',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "任务列表",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ReorderableListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final uncompletedTasks = taskItems
                                .where((task) => !task.isCompleted)
                                .toList();
                            final item = uncompletedTasks.removeAt(oldIndex);
                            uncompletedTasks.insert(newIndex, item);

                            taskItems = [
                              ...uncompletedTasks,
                              ...taskItems.where((task) => task.isCompleted),
                            ];
                          });
                        },
                        children: taskItems
                            .where((task) => !task.isCompleted)
                            .toList()
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final task = entry.value;
                          return Padding(
                            key: ValueKey(task.id),
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Container(
                                    width: 12.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      setState(() {
                                        _editingStates[task.id] = hasFocus;
                                      });
                                    },
                                    child: TextFormField(
                                      initialValue: task.content,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        isDense: true,
                                      ),
                                      style: TextStyle(fontSize: 14.sp),
                                      onChanged: (value) {
                                        setState(() {
                                          final index = taskItems.indexWhere(
                                              (t) => t.id == task.id);
                                          taskItems[index] =
                                              task.copyWith(content: value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                SizedBox(
                                  width: 32.w,
                                  height: 32.h,
                                  child: _editingStates[task.id] == true
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                            size: 20.r,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              taskItems.removeWhere(
                                                  (t) => t.id == task.id);
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                        )
                                      : ReorderableDragStartListener(
                                          index: index,
                                          child: Icon(
                                            Icons.drag_handle,
                                            color: Colors.grey,
                                            size: 20.r,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextFormField(
                                controller: newTaskController,
                                focusNode: newTaskFocus,
                                decoration: InputDecoration(
                                  hintText: '添加任务',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14.sp,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                                onEditingComplete: () {
                                  if (newTaskController.text
                                      .trim()
                                      .isNotEmpty) {
                                    setState(() {
                                      taskItems.add(TaskItem(
                                        id: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString(),
                                        content: newTaskController.text.trim(),
                                        isCompleted: false,
                                      ));
                                      newTaskController.clear();
                                    });
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (taskItems.any((task) => task.isCompleted)) ...[
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
                          itemCount: taskItems
                              .where((task) => task.isCompleted)
                              .length,
                          itemBuilder: (context, index) {
                            final task = taskItems
                                .where((task) => task.isCompleted)
                                .toList()[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
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
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                ],
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
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('取消'),
                  ),
                  SizedBox(width: 16.w),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final nonEmptyTasks = taskItems
                            .where((task) => task.content.trim().isNotEmpty)
                            .toList();

                        final updatedFestival = widget.festival.copyWith(
                          festivalName: nameController.text,
                          taskItem: nonEmptyTasks,
                          data: currentDate,
                        );
                        widget.onSave(updatedFestival);
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => TaskDialog(
                            festival: updatedFestival,
                            onSave: widget.onSave,
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text('保存'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
