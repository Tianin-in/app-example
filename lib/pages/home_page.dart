import 'package:festival_app/colors.dart';
import 'package:festival_app/components/festival_card.dart';
import 'package:festival_app/components/task_dialog.dart';
import 'package:festival_app/model/festical_card.dart';
import 'package:festival_app/pages/login_page_other.dart';
import 'package:festival_app/providers/weather_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:festival_app/providers/festival_and_tasks_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:festival_app/providers/wechat_auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:lunar/calendar/Lunar.dart';

final counterTasksProvider = StateProvider<int>((ref) => 0); // 初始化为0

class HomePage extends StatefulHookConsumerWidget {
  final String? avatarUrl;

  const HomePage({
    super.key,
    this.avatarUrl,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //late Future<List<FestivalCardModel>> _festivalData;

  @override
  void initState() {
    super.initState();
    // 初始化数据
    // _festivalData = fetchFestivalData();
    ref.read(weatherProvider.notifier).fetchWeather('500113');
    // print(_festivalData);
  }

  // 更新方法
  // void _reloadFestivalData() {
  //   setState(() {
  //     _festivalData = fetchFestivalData(); // 重新加载数据
  //   });
  // }

  // 动态渲染festival卡片数据
  // Future<List<FestivalCardModel>> fetchFestivalData() async {
  //   try {
  //     // 模拟异步获取数据
  //     await Future.delayed(const Duration(microseconds: 500));

  //     return festivalData
  //         .map((json) => FestivalCardModel.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     print("Error occurred: $e");
  //     rethrow;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final basePadding = MediaQuery.of(context).size.width * 0.1;
    final festivalsAsync = ref.watch(festivalAndTasksListProvider);
    final wechatAuthState = ref.watch(wechatAuthProvider);

    final weather = ref.watch(weatherProvider); // 天气

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 4.w),
                      Text(
                        wechatAuthState.when(
                          data: (state) => state.isAuthenticated
                              ? 'Hi ! ${state.nickname ?? 'moco'}'
                              : 'Hi ! 游客',
                          loading: () => 'Hi ! 游客',
                          error: (_, __) => 'Hi ! 游客',
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/message');
            //   },
            //   child: Image.asset(
            //     "assets/images/icon/Mail.png",
            //     height: 25.h,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPageOther(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: wechatAuthState.when(
                  data: (state) => state.isAuthenticated
                      ? GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/profilePage'),
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundImage: state.avatarUrl != null
                                ? CachedNetworkImageProvider(
                                    state.avatarUrl!,
                                    errorListener: (error) => const AssetImage(
                                        "assets/images/avatar.png"),
                                  )
                                : const AssetImage("assets/images/avatar.png")
                                    as ImageProvider,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '登录',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '登录',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 30.sp,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0), // 阴影的偏移量
                                blurRadius: 5.0, // 阴影模糊半径
                                color: const Color.fromARGB(255, 119, 118, 118)
                                    .withOpacity(0.5), // 阴影颜色，50%的透明度
                              ),
                            ],
                          ),
                          text:
                              "${DateTime.now().month}月${DateTime.now().day}日",
                          children: [
                            TextSpan(
                                text:
                                    "(${_getChineseWeekday(DateTime.now().weekday)})",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0), // 阴影的偏移量
                                      blurRadius: 5.0, // 阴影模糊半径
                                      color: const Color.fromARGB(
                                              255, 119, 118, 118)
                                          .withOpacity(0.5), // 阴影颜色，50%的透明度
                                    ),
                                  ],
                                ))
                          ])),
                      Text(
                          "${weather?.province}.${weather?.city} ${weather?.temperature}℃ ${weather?.weather}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0), // 阴影的偏移量
                                blurRadius: 5.0, // 阴影模糊半径
                                color: const Color.fromARGB(255, 119, 118, 118)
                                    .withOpacity(0.5), // 阴影颜色，50%的透明度
                              ),
                            ],
                          )),
                      Text.rich(
                        TextSpan(
                          text:
                              '${Lunar.fromYmd(DateTime.now().year, DateTime.now().month, DateTime.now().day).getBaZi()}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0), // 阴影的偏移量
                                blurRadius: 5.0, // 阴影模糊半径
                                color: const Color.fromARGB(255, 119, 118, 118)
                                    .withOpacity(0.5), // 阴影颜色，50%的透明度
                              ),
                            ],
                          ),
                          children: [
                            TextSpan(
                                text: ' ·中国人民警察节 三九第3天',
                                style: TextStyle(
                                  color: Color(0xFF9A9A9A),
                                  fontSize: 10.sp,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       bottom: basePadding, right: basePadding),
                  //   child: SizedBox(
                  //     width: 80.w,
                  //     child: Lottie.asset(LotteWeather.rainLight),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.r),
              ),
              height: MediaQuery.of(context).size.height * 0.4, // 指定高度
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/card_backgroud.png', // 替换为你的背景图片路径
                      fit: BoxFit.cover, // 确保图片覆盖整个底部
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  "CD",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFF5F5F5)
                                        .withOpacity(0.71), // 设置透明背景 (透明度 30%)
                                    borderRadius:
                                        BorderRadius.circular(21), // 圆角
                                  ),
                                  child: Row(
                                    children: [
                                      Text("定制计划"),
                                      Icon(
                                        Icons.border_color,
                                        size: 15.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60, left: 30),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: '计划     ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1.0, 1.0), // 阴影的偏移量
                                            blurRadius: 5.0, // 阴影模糊半径
                                            color: const Color.fromARGB(
                                                    255, 119, 118, 118)
                                                .withOpacity(
                                                    0.5), // 阴影颜色，50%的透明度
                                          ),
                                        ],
                                      ),
                                      children: const [
                                        TextSpan(
                                            text: '0',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 56, 56, 56),
                                              fontSize: 20,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Text("除夕",
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset:
                                                  Offset(1.0, 1.0), // 阴影的偏移量
                                              blurRadius: 5.0, // 阴影模糊半径
                                              color: const Color.fromARGB(
                                                      255, 119, 118, 118)
                                                  .withOpacity(
                                                      0.5), // 阴影颜色，50%的透明度
                                            ),
                                          ],
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600)),
                                  Text("1月29日",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                  Text("Chinese New Year's Eve",
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset:
                                                  Offset(2.0, 2.0), // 阴影的偏移量
                                              blurRadius: 5.0, // 阴影模糊半径
                                              color: const Color(0XFF767679)
                                                  .withOpacity(
                                                      0.5), // 阴影颜色，50%的透明度
                                            ),
                                          ],
                                          color: const Color(0XFF767679)
                                              .withOpacity(0.5),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(
                        " .展示国家法定节假日和定制假期",
                        style:
                            TextStyle(fontSize: 9.sp, color: Color(0XFF9A9A9A)),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("近期节日",
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w900)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.w),
              child: SizedBox(
                height: 158.h,
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
                    data: (festivals) => RefreshIndicator(
                          onRefresh: () =>
                              ref.refresh(festivalAndTasksListProvider.future),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 16.w),
                            scrollDirection: Axis.horizontal,
                            itemCount: festivals.length,
                            itemBuilder: (context, index) {
                              final festival = festivals[index];
                              print(festival.toJson());
                              return GestureDetector(
                                onTap: () => {
                                  showDialog(
                                      context: context,
                                      barrierColor: Colors.black54,
                                      builder: (context) =>
                                          TweenAnimationBuilder(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            tween: Tween<double>(
                                                begin: 0.8, end: 1.0),
                                            builder:
                                                (context, double value, child) {
                                              return Transform.scale(
                                                scale: value,
                                                child: child,
                                              );
                                            },
                                            child: TaskDialog(
                                              festival: festival,
                                              onSave: (updatedFestival) {
                                                ref
                                                    .read(
                                                        festivalAndTasksListProvider
                                                            .notifier)
                                                    .updateFestivalAndTasks(
                                                        index, updatedFestival);
                                              },
                                            ),
                                          ))
                                },
                                child: FestivalCard(
                                    festivalName: festival.festivalName,
                                    data: festival.data,
                                    imageUrl: festival.imageUrl,
                                    plans: festival.plans,
                                    description: festival.festivalDescription),
                              );
                            },
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 40.h,
            )
          ],
        ),
      ),
    );
  }

  String _getChineseWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      case 7:
        return '周日';
      default:
        return '未知';
    }
  }
}
