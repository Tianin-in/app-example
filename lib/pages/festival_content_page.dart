import 'package:festival_app/components/festival_deadline.dart';
import 'package:festival_app/components/select_month.dart';
import 'package:festival_app/components/task_dialog.dart';
import 'package:festival_app/enums.dart';
import 'package:festival_app/providers/festival_and_tasks_provider.dart';
import 'package:festival_app/providers/wechat_auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FestivalContent extends StatefulHookConsumerWidget {
  const FestivalContent({super.key});

  @override
  ConsumerState<FestivalContent> createState() => _FestivalContentState();
}

class _FestivalContentState extends ConsumerState<FestivalContent> {
  final ScrollController _scrollController = ScrollController();
  FestivalFilter currentFilter = FestivalFilter.all;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final festivalsAsync = ref.watch(festivalAndTasksListProvider);
    final wechatAuth = ref.watch(wechatAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SelectMonth(
              onMonthSelected: (DateTime date) {
                ref
                    .read(festivalAndTasksListProvider.notifier)
                    .setSelectedDate(date);
              },
            ),
            SizedBox(width: 10.w),
            Text.rich(
              TextSpan(
                text: "所有假期",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: '.中国',
                    style: TextStyle(color: Color(0XFF9A9A9A), fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: wechatAuth.when(
              data: (data) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profilePage'),
                child: CircleAvatar(
                  backgroundImage: data.avatarUrl != null
                      ? CachedNetworkImageProvider(data.avatarUrl!)
                      : const AssetImage('assets/images/avatar.png')
                          as ImageProvider,
                  radius: 20.r,
                ),
              ),
              loading: () => GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/profilePage'),
                  child: const CircularProgressIndicator()),
              error: (_, __) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profilePage'),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 20.r,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _FilterButton(
                      label: "国家法定",
                      isSelected: currentFilter == FestivalFilter.official,
                      onTap: () {
                        setState(() {
                          currentFilter = FestivalFilter.official;
                        });
                        ref
                            .read(festivalAndTasksListProvider.notifier)
                            .setFilter(FestivalFilter.official);
                      },
                    ),
                    SizedBox(width: 8.w),
                    _FilterButton(
                      label: "自定义",
                      isSelected: currentFilter == FestivalFilter.custom,
                      onTap: () {
                        setState(() {
                          currentFilter = FestivalFilter.custom;
                        });
                        ref
                            .read(festivalAndTasksListProvider.notifier)
                            .setFilter(FestivalFilter.custom);
                      },
                    ),
                    SizedBox(width: 8.w),
                    _FilterButton(
                      label: "所有",
                      isSelected: currentFilter == FestivalFilter.all,
                      onTap: () {
                        setState(() {
                          currentFilter = FestivalFilter.all;
                        });
                        ref
                            .read(festivalAndTasksListProvider.notifier)
                            .setFilter(FestivalFilter.all);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.04),
                child: Row(
                  children: [
                    Text(
                      "8 ",
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w500),
                    ),
                    Text("个计划",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400))
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: festivalsAsync.when(
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stack) => Center(
                      child: SelectableText.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: '加载失败\n',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: error.toString()),
                          ],
                        ),
                      ),
                    ),
                data: (festivals) {
                  //根据筛选条件过滤节日
                  print("shaixuan");
                  festivals = ref
                      .read(festivalAndTasksListProvider.notifier)
                      .applyFilters(
                        festivals,
                      );

                  DateTime now = DateTime.now();

                  festivals = festivals.map((festival) {
                    // 计算当前日期与节日日期的天数差
                    Duration difference = festival.data.difference(now);

                    if (difference.inDays < 0) {
                      festival = festival.copyWith(state: "1");
                    } else {
                      festival = festival.copyWith(state: "2");
                    }

                    // 使用 copyWith 创建一个新的 FestivalAndTasks 实例，更新 countDown 值
                    return festival.copyWith(
                        countDown: difference.inDays,
                        plans: festival.taskItem.length);
                  }).toList();

                  // 对节日数据进行排序
                  final sortedFestivals = List.of(festivals)
                    ..sort((a, b) {
                      final stateComparison = b.state.compareTo(a.state);
                      if (stateComparison < 0) {
                        return stateComparison;
                      }
                      // 如果state相同，则根据data进行比较
                      return a.data.compareTo(b.data);
                    });

                  return RefreshIndicator(
                    onRefresh: () =>
                        ref.refresh(festivalAndTasksListProvider.future),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: sortedFestivals.length,
                        itemBuilder: (context, index) {
                          final festival = sortedFestivals[index];

                          return GestureDetector(
                            onTap: () {
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
                                  child: TaskDialog(
                                    festival: festival,
                                    onSave: (updatedFestival) {
                                      // 找到原始列表中的索引
                                      final originalIndex =
                                          festivals.indexOf(festival);
                                      ref
                                          .read(festivalAndTasksListProvider
                                              .notifier)
                                          .updateFestivalAndTasks(
                                              originalIndex, updatedFestival);
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Dismissible(
                              key: Key(festival.id),
                              direction: DismissDirection.endToStart, // 左滑
                              background: GestureDetector(
                                onTap: () {
                                  // 点击删除图标时弹出确认提示框
                                  _showDeleteConfirmation(context, index);
                                },
                                child: Container(
                                  color: Colors.red, // 背景为红色
                                  width: MediaQuery.of(context).size.width /
                                      5, // 删除图标占屏幕的五分之一
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white), // 删除图标
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {
                                // 处理删除逻辑
                              },
                              child: FestivalDeadline(
                                festivalName: festival.festivalName,
                                data: festival.data,
                                festivalState: _setFestivalStatus(int.tryParse(
                                        festival.state?.toString() ?? '') ??
                                    0),
                                imageUrl: festival.imageUrl,
                                coumtDown: festival.countDown,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  FestivalState _setFestivalStatus(int state) {
    switch (state) {
      case 1:
        return FestivalState.completed;
      case 2:
        return FestivalState.ongoing;
      case 3:
        return FestivalState.notStarted;
      default:
        return FestivalState.completed;
    }
  }
}

// 显示删除确认提示框
void _showDeleteConfirmation(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('确认删除 Item $index 吗?', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 关闭提示框
                  },
                  child: Text('取消'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 在这里执行删除操作
                    print('Item $index 被删除');
                    Navigator.of(context).pop(); // 关闭提示框
                  },
                  child: Text('确认'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78.w,
        height: 21.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? Colors.black : Colors.grey[300],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 10.sp,
            ),
          ),
        ),
      ),
    );
  }
}
//==============================================
