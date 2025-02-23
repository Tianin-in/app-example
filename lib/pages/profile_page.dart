import 'package:cached_network_image/cached_network_image.dart';
import 'package:festival_app/providers/wechat_auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wechatAuth = ref.watch(wechatAuthProvider);
    final wechatAuthState = ref.watch(wechatAuthProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),

        // leading: Container(
        //   decoration: BoxDecoration(
        //       color: Colors.black, borderRadius: BorderRadius.circular(20.r)),
        //   child: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                    child: Row(
                      children: [
                        wechatAuth.when(
                            data: (data) => CircleAvatar(
                                  backgroundImage: data.avatarUrl != null
                                      ? CachedNetworkImageProvider(
                                          data.avatarUrl!)
                                      : const AssetImage(
                                              'assets/images/avatar.png')
                                          as ImageProvider,
                                  radius: 30.r,
                                ),
                            error: (_, __) => CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: const AssetImage(
                                      'assets/images/avatar.png'),
                                ),
                            loading: () => CircleAvatar(
                                  radius: 30.r,
                                  backgroundImage: const AssetImage(
                                      'assets/images/avatar.png'),
                                )),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    wechatAuthState.when(
                                      data: (state) => state.isAuthenticated
                                          ? '${state.nickname}'
                                          : 'mococo',
                                      loading: () => 'mococo',
                                      error: (_, __) => 'mococo',
                                    ),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.edit, size: 20.sp),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'ID: 10001',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '签名：人生不是轨道，是旷野',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                    child: InkWell(
                      onTap: () {
                        // 这里没有支付逻辑，只是设计
                        print('支付按钮被点击');
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h), // 上下内边距
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.record_voice_over,
                                color: Colors.green, size: 24), // 支付图标
                            SizedBox(width: 10.w),
                            Text(
                              // 限制最多显示一行
                              "欢迎使用节日记，我们后续将推出更多功能，如果有什么问题，欢迎反馈给我们", // 支付名称
                              style: TextStyle(
                                fontSize: 10.sp, // 字体大小
                                fontWeight: FontWeight.w400, // 字体加粗
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis, // 超出时显示省略号
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Menu Items
                  SizedBox(height: 16.h),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                      children: [
                        _buildMenuItem(
                          icon: Icons.phone,
                          title: '手机号',
                          showArrow: false,
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.message,
                          title: '联系我们',
                          showArrow: true,
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.storage,
                          title: '储存空间',
                          showArrow: false,
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.info_outline,
                          title: '当前版本',
                          showArrow: false,
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.description_outlined,
                          title: '用户协议',
                          showArrow: true,
                        ),

                        _buildDivider(),
                        // print("object");
                        //     Navigator.pushNamed(context, '/privacy');
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/privacy');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            child: Row(
                              children: [
                                Icon(Icons.privacy_tip_outlined,
                                    size: 20.sp, color: Colors.black87),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    "隐私政策",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                if (true)
                                  Icon(Icons.arrow_forward_ios,
                                      size: 16.sp, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        _buildMenuItem(
                          icon: Icons.person_remove_outlined,
                          title: '注销账号',
                          showArrow: false,
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.logout,
                          title: '退出账号',
                          showArrow: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 备案号
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              '备案号: 渝ICP备2025049777',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool showArrow,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colors.black87),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
          ),
          if (showArrow)
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: Colors.grey[200],
      indent: 16.w,
      endIndent: 16.w,
    );
  }
}
