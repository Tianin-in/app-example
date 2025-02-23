import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageNotifactionComponent extends StatelessWidget {
  final String avatorImage;
  final String name;
  final String messageInfo;

  const MessageNotifactionComponent({
    super.key,
    required this.avatorImage,
    required this.name,
    required this.messageInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: Container(
        padding: EdgeInsets.only(left: 15.w),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  avatorImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  messageInfo,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 14.sp,
                    color: Color(0xFF545454),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
