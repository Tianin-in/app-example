// import 'package:fluwx/fluwx.dart' as fluwx;

// void _login() async {
//   final result = await fluwx.sendWeChatAuth(
//     scope: "snsapi_userinfo",
//     state: "wechat_sdk_demo_test",
//   );

//   if (result != null && result is fluwx.WeChatAuthResponse) {
//     // 获取到的 result 里包含了 code 和状态信息
//     if (result.errCode == 0) {
//       // 通过 result.code 请求后台交换 access_token 和 openid
//       print("微信登录成功, code: ${result.code}");
//     } else {
//       print("微信登录失败");
//     }
//   }
// }
