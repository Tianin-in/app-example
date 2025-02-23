import 'dart:ffi';

import 'package:festival_app/colors.dart';
import 'package:festival_app/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FestivalDeadline extends StatelessWidget {
  final String festivalName;
  final DateTime data;
  final String imageUrl;
  final FestivalState festivalState;
  final int coumtDown;

  const FestivalDeadline(
      {super.key,
      required this.festivalName,
      required this.data,
      required this.coumtDown,
      required this.imageUrl,
      required this.festivalState});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      margin: const EdgeInsets.symmetric(vertical: 4), // 为阴影留出空间
      decoration: BoxDecoration(
        color: _getFestivalStatusColor(festivalState),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 209, 208, 208),
            offset: Offset(0, 1), // 设置为 (0, 2) 使阴影更均匀
            blurRadius: 1, // 调整模糊度来创建柔和的阴影
            // spreadRadius: 1, // 增加 spreadRadius 使阴影四周扩展
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  festivalName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  DateFormat('yyyy MM-dd').format(data),
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0XFF545454),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: _getFestivalStatusWidget(festivalState, data),
            )
          ],
        ),
      ),
    );
  }

  // 根据不同的状态返回文本
  Widget _getFestivalStatusWidget(FestivalState state, DateTime end) {
    switch (state) {
      case FestivalState.completed:
        return Text(
          "已结束",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        );
      case FestivalState.ongoing:
        return Row(
          children: [
            Text("倒计时  ",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              height: 31,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  coumtDown.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Text("  天",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
          ],
        );
      case FestivalState.notStarted:
        return Container();
      default:
        return Container();
    }
  }

  int differTime(DateTime end) {
    DateTime tim = DateTime.now();
    return end.difference(tim).inDays;
  }

  Color _getFestivalStatusColor(FestivalState state) {
    switch (state) {
      case FestivalState.completed:
        return AppColors.blueOne;
      case FestivalState.ongoing:
        return AppColors.blueTwo;
      case FestivalState.notStarted:
        return AppColors.blueFour;
      default:
        return AppColors.blueThree;
    }
  }

  String _getCountdown(String targetDateString) {
    DateTime targetDate = DateTime.parse(targetDateString);
    Duration difference = targetDate.isAfter(DateTime.now())
        ? targetDate.difference(DateTime.now())
        : Duration.zero;

    int days = difference.inDays;

    return '$days';
  }
}
