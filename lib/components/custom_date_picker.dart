import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class CustomDatePicker extends HookConsumerWidget {
  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  final DateTime initialDate;
  final void Function(DateTime) onDateSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      width: 600.w,
      height: 350.h,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // 左侧日历部分
                Expanded(
                  flex: 2.bitLength,
                  child: _CalendarView(
                    selectedDate: selectedDate,
                    onDateSelected: (date) {
                      ref.read(selectedDateProvider.notifier).state = date;
                    },
                  ),
                ),
                // 右侧月份列表
                Expanded(
                  child: _MonthListView(
                    selectedDate: selectedDate,
                    onMonthSelected: (month) {
                      final newDate = DateTime(
                        selectedDate.year,
                        month,
                        selectedDate.day,
                      );
                      ref.read(selectedDateProvider.notifier).state = newDate;
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('取消'),
                ),
                SizedBox(width: 8.w),
                TextButton(
                  onPressed: () {
                    onDateSelected(selectedDate);
                    Navigator.of(context).pop();
                  },
                  child: const Text('保存'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView({
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  bool _isBeforeToday(DateTime date) {
    final today = DateTime.now();
    return date.isBefore(DateTime(today.year, today.month, today.day));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 年份选择器
        SizedBox(
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.chevron_left, size: 20.w),
                onPressed: () => onDateSelected(
                  DateTime(
                    selectedDate.year - 1,
                    selectedDate.month,
                    selectedDate.day,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                selectedDate.year.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(width: 8.w),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.chevron_right, size: 20.w),
                onPressed: () => onDateSelected(
                  DateTime(
                    selectedDate.year + 1,
                    selectedDate.month,
                    selectedDate.day,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 星期标题行
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '一',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '二',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '三',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '四',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '五',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '六',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '日',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // 日历网格
        SizedBox(
          height: 160.h,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 4.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final firstDayOfMonth =
                  DateTime(selectedDate.year, selectedDate.month, 1);
              final firstWeekday = firstDayOfMonth.weekday % 7;
              final previousMonthDays = DateTime(
                selectedDate.year,
                selectedDate.month,
                0,
              ).day;

              late final DateTime date;
              late final bool isCurrentMonth;

              if (index < firstWeekday) {
                // 上月日期
                final day = previousMonthDays - (firstWeekday - index - 1);
                date = DateTime(selectedDate.year, selectedDate.month - 1, day);
                isCurrentMonth = false;
              } else {
                final daysInMonth = DateTime(
                  selectedDate.year,
                  selectedDate.month + 1,
                  0,
                ).day;
                final day = index - firstWeekday + 1;

                if (day <= daysInMonth) {
                  // 当月日期
                  date = DateTime(selectedDate.year, selectedDate.month, day);
                  isCurrentMonth = true;
                } else {
                  // 下月日期
                  final nextMonthDay = day - daysInMonth;
                  date = DateTime(
                      selectedDate.year, selectedDate.month + 1, nextMonthDay);
                  isCurrentMonth = false;
                }
              }

              final isBeforeToday = _isBeforeToday(date);
              final isSelectable = isCurrentMonth && !isBeforeToday;

              final isSelected = isSelectable &&
                  date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;

              return Container(
                margin: const EdgeInsets.all(1),
                child: InkWell(
                  onTap: isSelectable ? () => onDateSelected(date) : null,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : null,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: !isCurrentMonth
                              ? const Color.fromARGB(255, 165, 164, 164)
                              : isBeforeToday
                                  ? Color.fromARGB(255, 184, 183, 183)
                                  : isSelected
                                      ? Colors.white
                                      : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MonthListView extends StatelessWidget {
  const _MonthListView({
    required this.selectedDate,
    required this.onMonthSelected,
  });

  final DateTime selectedDate;
  final ValueChanged<int> onMonthSelected;

  String _getMonthName(int month) {
    const months = [
      '一月',
      '二月',
      '三月',
      '四月',
      '五月',
      '六月',
      '七月',
      '八月',
      '九月',
      '十月',
      '十一月',
      '十二月'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.grey[300]!,
            width: 1.w,
          ),
        ),
      ),
      child: Stack(
        children: [
          ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(
              initialItem: selectedDate.month - 1,
            ),
            onSelectedItemChanged: (index) {
              onMonthSelected(index + 1);
            },
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 12, // 只显示12个月
              builder: (context, index) {
                final month = index + 1;
                final isSelected = month == selectedDate.month;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Center(
                    child: Text(
                      _getMonthName(month),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isSelected ? Colors.blue : Colors.black87,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 中间选中区域的指示器
          Center(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
