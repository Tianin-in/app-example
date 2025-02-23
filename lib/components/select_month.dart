import 'package:festival_app/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectMonth extends StatefulWidget {
  final Function(DateTime) onMonthSelected;

  const SelectMonth({
    Key? key,
    required this.onMonthSelected,
  }) : super(key: key);

  @override
  _SelectMonthState createState() => _SelectMonthState();
}

class _SelectMonthState extends State<SelectMonth> {
  String _selectedMonth = '1月';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(0, 10.h),
      position: PopupMenuPosition.under,
      constraints: BoxConstraints(
        maxHeight: 100.h,
        minWidth: 70.w,
        maxWidth: 70.w,
      ),
      onSelected: (String value) {
        setState(() {
          _selectedMonth = value;
        });
        // 将选中的月份转换为DateTime对象
        final month = int.parse(value.replaceAll('月', ''));
        final now = DateTime.now();
        widget.onMonthSelected(DateTime(now.year, month));
      },
      color: Colors.black,
      elevation: 4.w,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      itemBuilder: (context) => [
        for (int i = 1; i <= 12; i++)
          PopupMenuItem<String>(
            value: '${i}月',
            height: 35.h,
            padding: EdgeInsets.zero,
            child: Container(
              width: 60.w,
              decoration: BoxDecoration(
                color: _selectedMonth == '${i}月'
                    ? Colors.grey[800]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Text(
                  '${i}月',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
      child: Container(
        width: 60.w,
        height: 31.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(17.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/ChevronDown.png"),
            Text(
              _selectedMonth,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
