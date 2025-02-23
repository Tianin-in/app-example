import 'package:festival_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String value;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: AppColors.loginInputContainer, // 浅蓝色背景
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ), // 圆角

        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 121, 120, 120)
                .withOpacity(0.1), // 阴影颜色，10%透明的黑色
            blurRadius: 10, // 模糊半径，值越大越柔和
            spreadRadius: 1, // 扩散半径，让阴影更大一些
            offset: Offset(3.w, 3.h), // 偏移为 0，阴影分布在上下左右
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 左边标题
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          // 右边内容
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInputFieldRigte extends StatefulWidget {
  final String label;
  final String value;

  const CustomInputFieldRigte({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  State<CustomInputFieldRigte> createState() => _CustomInputFieldRigteState();
}

class _CustomInputFieldRigteState extends State<CustomInputFieldRigte> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: AppColors.loginButtonRight, // 浅蓝色背景
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          bottomLeft: Radius.circular(30.r),
        ), // 圆角

        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 121, 120, 120)
                .withOpacity(0.1), // 阴影颜色，10%透明的黑色
            blurRadius: 10, // 模糊半径，值越大越柔和
            spreadRadius: 1, // 扩散半径，让阴影更大一些
            offset: Offset(3.w, 3.h), // 偏移为 0，阴影分布在上下左右
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 左边标题
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          // 右边内容
          Text(
            widget.value,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
