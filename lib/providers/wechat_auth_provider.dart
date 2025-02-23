import 'dart:async';
import 'package:festival_app/enums.dart';
import 'package:festival_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluwx/fluwx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

part 'wechat_auth_provider.freezed.dart';

@freezed
class WechatAuthState with _$WechatAuthState {
  const factory WechatAuthState({
    @Default(LoginStatus.initial) LoginStatus status,
    @Default(null) AuthErrorType? errorType,
    @Default(null) String? errorMessage,
    @Default(null) WeChatAuthResponse? authResponse,
    @Default(false) bool isAuthenticated,
    String? code,
    String? nickname,
    String? avatarUrl,
  }) = _WechatAuthState;
}

final wechatAuthProvider =
    AsyncNotifierProvider<WechatAuthNotifier, WechatAuthState>(() {
  return WechatAuthNotifier();
});

class WechatAuthNotifier extends AsyncNotifier<WechatAuthState> {
  Timer? _timeoutTimer;

  @override
  Future<WechatAuthState> build() async {
    ref.onDispose(() => _timeoutTimer?.cancel());
    // 监听微信响应
    weChatResponseEventHandler.listen(_handleWeChatResponse);
    return const WechatAuthState();
  }

  Future<void> _handleAuthSuccess(String code) async {
    try {
      developer.log('开始处理微信授权成功: $code');

      // 使用code获取access_token
      final tokenResponse = await http
          .get(Uri.parse('https://api.weixin.qq.com/sns/oauth2/access_token?'
              'appid=wx0b3db4684108f23b'
              '&secret=7ba2836e66c736365f0eb8453d99ecf8'
              '&code=$code'
              '&grant_type=authorization_code'));

      developer.log('获取token响应: ${tokenResponse.body}');

      final tokenData = json.decode(tokenResponse.body);
      if (tokenData['errcode'] != null) {
        throw Exception('获取access_token失败: ${tokenData['errmsg']}');
      }

      final accessToken = tokenData['access_token'];
      final openid = tokenData['openid'];

      // 获取用户信息
      final userInfoResponse =
          await http.get(Uri.parse('https://api.weixin.qq.com/sns/userinfo?'
              'access_token=$accessToken'
              '&openid=$openid'));

      developer.log('获取用户信息响应: ${userInfoResponse.body}');

      final userData = json.decode(userInfoResponse.body);
      if (userData['errcode'] != null) {
        throw Exception('获取用户信息失败: ${userData['errmsg']}');
      }

      List<int> isoBytes = latin1.encode(userData['nickname']); // 使用 latin1 编码
      // Step 2: 将字节数组解码为 UTF-8 编码的 String
      String nickname = utf8.decode(isoBytes); // 解码为 UTF-8 字符串

      state = AsyncData(WechatAuthState(
        isAuthenticated: true,
        code: code,
        nickname: nickname,
        avatarUrl: userData['headimgurl'],
      ));

      // 保存用户信息到本地存储
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('wx_nickname', userData['nickname']);
      await prefs.setString('wx_avatar', userData['headimgurl']);

      // 导航到主页
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/home',
        (route) => false, // 移除所有路由
      );
    } catch (e, stack) {
      developer.log('微信登录错误', error: e, stackTrace: stack);
      state = AsyncError(e, stack);
    }
  }

  void _handleWeChatResponse(BaseWeChatResponse resp) {
    developer.log('收到微信响应', error: resp);

    if (resp is WeChatAuthResponse) {
      if (resp.code != null) {
        _handleAuthSuccess(resp.code!);
      } else {
        state = AsyncError(
          '微信授权失败: ${resp.state}',
          StackTrace.current,
        );
      }
    }
  }

  Future<void> signInWithWeChat() async {
    try {
      state = const AsyncLoading();
      developer.log('开始微信登录流程');

      // 检查微信是否安装
      final isInstalled = await isWeChatInstalled;
      developer.log('微信安装状态: $isInstalled');

      if (!isInstalled) {
        throw Exception('请先安装微信');
      }

      // 重新注册SDK以确保状态正确
      developer.log('尝试注册微信SDK');
      final registerResult = await registerWxApi(
        appId: "wx0b3db4684108f23b",
        universalLink: "https://www.milcomo.cn/",
        doOnAndroid: true,
        doOnIOS: true,
      );
      developer.log('SDK注册结果: $registerResult');

      // 发起授权
      developer.log('准备发起微信授权');
      final result = await sendWeChatAuth(
        scope: "snsapi_userinfo",
        state: "festival_app_auth_${DateTime.now().millisecondsSinceEpoch}",
      );
      developer.log('发起授权结果: $result');

      if (!result) {
        throw Exception('发起微信授权失败');
      }

      // 设置超时检查
      _timeoutTimer?.cancel();
      _timeoutTimer = Timer(const Duration(seconds: 30), () {
        if (state is AsyncLoading) {
          state = AsyncError('微信登录超时', StackTrace.current);
        }
      });
    } catch (e, stack) {
      developer.log('微信登录错误', error: e, stackTrace: stack);
      state = AsyncError(e, stack);
      rethrow; // 重新抛出错误以便UI层捕获
    }
  }

  // 弹出提示框的函数
  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );

    // 延时 2 秒后关闭弹窗
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  void handleWeChatResponse(WeChatAuthResponse resp) =>
      _handleWeChatResponse(resp);
}
