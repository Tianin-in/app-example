import 'package:festival_app/colors.dart';
import 'package:festival_app/enums.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:festival_app/providers/wechat_auth_provider.dart';
import 'package:fluwx/fluwx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as developer;

class LoginPageOther extends StatefulHookConsumerWidget {
  const LoginPageOther({super.key});

  @override
  ConsumerState<LoginPageOther> createState() => _LoginPageOtherState();
}

class _LoginPageOtherState extends ConsumerState<LoginPageOther> {
  bool _isSelected = false; // 控制选中状态

  @override
  void initState() {
    super.initState();
    // Listen to WeChat auth response
    weChatResponseEventHandler.listen((resp) {
      if (resp is WeChatAuthResponse) {
        ref.read(wechatAuthProvider.notifier).handleWeChatResponse(resp);
      }
    });
  }

  Future<void> _handleWeChatLogin() async {
    try {
      if (!await isWeChatInstalled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('请先安装微信'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      await ref.read(wechatAuthProvider.notifier).signInWithWeChat();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('登录失败: ${e.toString()}'),
        backgroundColor: Colors.red,
      ));
      developer.log('微信登录失败', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wechatAuth = ref.watch(wechatAuthProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                  height:
                      MediaQuery.of(context).size.height * 0.12.h), // 调整间距比例
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3.w, // 宽度
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.r), // 设置圆角
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.r),
                    child: Image.asset(
                      "assets/images/avatar.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.person,
                            size: 48.r,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Hi ! 新朋友",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
              ),
              Text(
                "请登录",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h), // 控制内部的间距
                  decoration: BoxDecoration(
                    color: AppColors.loginInputContainer, // 背景颜色
                    borderRadius: BorderRadius.circular(30.0.r), // 圆角半径
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 138, 137, 137)
                            .withOpacity(0.3), // 阴影颜色，透明度为30%
                        blurRadius: 10.r, // 模糊半径，值越大阴影越柔和
                        spreadRadius: 2.r, // 阴影扩散半径
                        offset: Offset(1, 1), // 阴影的偏移量，(x, y) 偏移
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
                    children: [
                      // 左侧的图标
                      GestureDetector(
                        onTap: _handleWeChatLogin,
                        child: wechatAuth.when(
                          data: (data) {
                            if (data.isAuthenticated) {
                              return const Text('登录成功');
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  height: 20.h,
                                  'assets/images/icon/wechat.png',
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  '微信登录',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ],
                            );
                          },
                          loading: () => SizedBox(
                            height: 20.h, // 设置固定高度
                            width: 15.w, // 设置固定宽度
                            child:
                                const CircularProgressIndicator(), // 使用CircularProgressIndicator
                          ),
                          error: (error, stack) => SelectableText.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '登录失败:\n',
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h), // 控制内部的间距
                  decoration: BoxDecoration(
                    color: AppColors.loginInputContainer, // 背景颜色
                    borderRadius: BorderRadius.circular(30.0.r), // 圆角半径
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 138, 137, 137)
                            .withOpacity(0.3), // 阴影颜色，透明度为30%
                        blurRadius: 10, // 模糊半径，值越大阴影越柔和
                        spreadRadius: 2, // 阴影扩散半径
                        offset: Offset(1, 1), // 阴影的偏移量，(x, y) 偏移
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
                    children: [
                      // 左侧的图标
                      Image.asset(
                        height: 20.h,
                        'assets/images/icon/qq.png', // 替换为您的图片路径
                      ),
                      SizedBox(width: 8.w), // 图标与文字之间的间距
                      // 右侧的文字
                      Text(
                        ' QQ  登录',
                        style: TextStyle(
                          fontSize: 18.sp, // 文字大小
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _isSelected,
                onChanged: (bool? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _isSelected = newValue;
                    });
                  }
                },
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // 防止显示过大
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.grey[600]!, // 圆的边框颜色
                    width: 2.r, // 边框宽度
                  ),
                ),
                checkColor: Colors.white, // 选中时的勾选颜色
                activeColor: Colors.blue, // 选中时的圆形背景颜色
                side: BorderSide(
                  color: Colors.grey[800]!, // 边框颜色
                  width: 2.r, // 边框宽度
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                  child: Text.rich(
                    TextSpan(
                      text: '我已阅读并同意',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                      children: const [
                        TextSpan(
                          text: '《用户协议》',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: '《隐私政策》'),
                        TextSpan(text: '《儿童/青少年个人信息保护规则》'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
