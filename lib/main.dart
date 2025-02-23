import 'dart:developer' as developer;
import 'package:festival_app/pages/home_page.dart';
import 'package:festival_app/pages/login_page.dart';
import 'package:festival_app/pages/login_page_other.dart';
import 'package:festival_app/pages/message_page.dart';
import 'package:festival_app/pages/profile_page.dart';
import 'package:festival_app/components/privacy_policy_page.dart';
import 'package:festival_app/presentation/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fluwx/fluwx.dart';

final navigatorKey = GlobalKey<NavigatorState>();



void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // 添加错误捕获
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      developer.log(
        'Flutter Error Details:',
        error: details.exception,
        stackTrace: details.stack,
      );
    };

    // 初始化微信SDK
    final initResult = await registerWxApi(
      appId: "",
      universalLink: "",
      doOnAndroid: true,
      doOnIOS: true,
    );

    developer.log('微信SDK初始化结果: $initResult');

    // 监听微信响应
    weChatResponseEventHandler.listen((resp) {
      developer.log('收到微信响应: $resp');
    }).onError((error) {
      developer.log('微信响应错误', error: error);
    });

    // 检查微信是否安装
    final isInstalled = await isWeChatInstalled;
    developer.log('微信是否已安装: $isInstalled');
  } catch (e, stack) {
    developer.log('初始化错误', error: e, stackTrace: stack);
  }

  runApp(
    const ProviderScope(
      observers: [ProviderLogger()],
      child: MyApp(),
    ),
  );
}

// Provider 日志记录
class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    developer.log('Provider 已添加: ${provider.name ?? provider.runtimeType}');
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    developer.log(
      'Provider 错误: ${provider.name ?? provider.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,

          routes: {
            '/login': (context) => const LoginPage(), // 首页路由
            '/loginOther': (context) => const LoginPageOther(), // 第二页路由
            '/home': (context) => const RootPage(), // 第二页路由
            '/message': (context) => MessageNotifaction(), // 第二页路由
            '/profilePage': (context) => ProfilePage(), // 第二页路由
            '/privacy': (context) => PrivacyPolicyPage(), // 第二页路由
          },

          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const RootPage(),
    );
  }
}
