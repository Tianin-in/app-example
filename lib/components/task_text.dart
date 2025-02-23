import 'package:festival_app/model/festival_and_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskItemWidget extends HookWidget {
  final TaskItem task;
  final bool isEditing;
  final ValueChanged<TaskItem> onChanged;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.isEditing,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final contentController = useTextEditingController(text: task.content);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  onChanged(task.copyWith(isCompleted: !task.isCompleted));
                },
                child: Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  size: 14.w,
                  color: task.isCompleted ? Colors.blue : Colors.grey,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: isEditing && !task.isCompleted
                    ? TextFormField(
                        controller: contentController,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: task.isCompleted
                              ? Colors.black54
                              : Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          onChanged(task.copyWith(content: value));
                        },
                      )
                    : Text(
                        task.content,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: task.isCompleted
                              ? Colors.black54
                              : Colors.black87,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1.h,
          thickness: 0.5.h,
          color: Colors.grey[300],
          indent: 20.w,
          endIndent: 20.w,
        ),
      ],
    );
  }
}
