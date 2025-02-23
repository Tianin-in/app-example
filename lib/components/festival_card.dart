import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FestivalCard extends StatelessWidget {
  // // 模拟一个 API 调用，返回节假日的数据
  // Future<Map<String, String>> fetchHolidayData() async {
  //   // 模拟网络延迟
  //   await Future.delayed(const Duration(seconds: 2));

  //   // 模拟返回的数据
  //   return {
  //     'imageUrl': 'https://example.com/haibao-chuxi.png',
  //     'title': '除夕',
  //     'date': 'Jan.28th',
  //     'planCount': '0',
  //     'planStatus': '暂无计划',
  //   };
  // }

  final String festivalName;
  final DateTime data;
  final String imageUrl;
  final int plans;
  final String description;

  const FestivalCard(
      {super.key,
      required this.festivalName,
      required this.data,
      required this.imageUrl,
      required this.description,
      required this.plans});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw, // 屏幕宽度的一半
      height: 158.h,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 17.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 72.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      festivalName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(data),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "计划             ",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          plans.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Text(
              description,
              style: TextStyle(fontSize: 9.sp, color: Color(0xFF9A9A9A)),
              overflow: TextOverflow.ellipsis, // 超出时显示省略号
              maxLines: 2, // 限制最多显示一行
            ),
          )
        ],
      ),
    );
  }
}
