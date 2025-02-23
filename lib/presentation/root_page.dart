import 'package:festival_app/components/drawe.dart';
import 'package:festival_app/components/edit_festival_page.dart';
import 'package:festival_app/components/task_dialog.dart';
import 'package:festival_app/model/festival_and_task.dart';
import 'package:festival_app/pages/festival_content_page.dart';
import 'package:festival_app/pages/login_page.dart';
import 'package:festival_app/pages/login_page_other.dart';
import 'package:festival_app/pages/message_page.dart';
import 'package:festival_app/providers/festival_and_tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/home_page.dart';

final currentPageProvider = StateProvider<int>((ref) => 0);

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtil.init(context, designSize: Size(390, 844));

    final currentPage = ref.watch(currentPageProvider);

    // 判断是否显示底部导航栏
    final bool showBottomNav = currentPage != 4; // 1 是登录页面的索引

    return Scaffold(
      backgroundColor: Color(0XFFF7F7F7),
      body: IndexedStack(
        index: currentPage,
        children: [
          HomePage(),
          FestivalContent(),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(top: 20),
        width: 65.w,
        child: FloatingActionButton.large(
          onPressed: () {
            showDialog(
                context: context,
                barrierColor: Colors.black54,
                builder: (context) => TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 200),
                      tween: Tween<double>(begin: 0.8, end: 1.0),
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: EditFestivalPage(
                        festival: FestivalAndTasks(
                            dayType: FestivalFilter.custom,
                            id: "",
                            festivalName: '',
                            festivalDescription: "",
                            data: DateTime.now(),
                            state: '0',
                            imageUrl: '',
                            plans: 0,
                            taskItem: [],
                            countDown: 0),
                        onSave: (saveFestival) {
                          ref
                              .read(festivalAndTasksListProvider.notifier)
                              .saveFestivalAndTask(saveFestival);
                        },
                      ),
                    ));
          },
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
          child: Container(
            width: 60.0.w,
            height: 50.0.h,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: CustomPaint(
              painter: PlusIconPainter(),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: showBottomNav
          ? BottomAppBar(
              height: MediaQuery.of(context).size.height * 0.08,
              shape: const CircularNotchedRectangle(), // 使中央按钮为圆形

              color: Color(0XFFF7F7F7),
              notchMargin: -10, // 设置中央按钮的空隙
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 左侧标签
                  IconButton(
                    icon: ImageIcon(
                        AssetImage('assets/images/icon/home-icon.png')),
                    onPressed: () =>
                        {ref.read(currentPageProvider.state).state = 0},
                  ),
                  // 中间的空位给 "+" 按钮留空
                  const SizedBox(width: 48), // 留出空间让 FAB 置中
                  // 右侧标签
                  IconButton(
                    icon:
                        ImageIcon(AssetImage('assets/images/icon/profile.png')),
                    onPressed: () =>
                        {ref.read(currentPageProvider.state).state = 1},
                  ),
                ],
              ),
            )
          : null, // 当 showBottomNav 为 false 时，不显示底部导航栏
    );
  }
}
