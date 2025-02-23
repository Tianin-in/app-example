import 'package:cached_network_image/cached_network_image.dart';
import 'package:festival_app/components/message_notifaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageNotifaction extends StatelessWidget {
  final String? avatarUrl;

  final List<Map<String, String>> messageData = List.generate(20, (index) {
    return {
      'avatorImage': 'assets/images/message_avator.png',
      'name': '小记活动助手', // 添加索引来模拟不同的名字
      'messageInfo': '活动更新啦，快来看看吧！', // 添加索引来模拟不同的消息内容
    };
  });

  MessageNotifaction({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // toolbarHeight: 20,
        title: const Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '消息',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: avatarUrl != null
                  ? CachedNetworkImageProvider(
                      avatarUrl!,
                      errorListener: (error) =>
                          const AssetImage("assets/images/avatar.png"),
                    )
                  : const AssetImage("assets/images/avatar.png")
                      as ImageProvider,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: messageData.length,
        itemBuilder: (context, index) {
          // 获取数据
          final message = messageData[index];

          // 使用 MessageNotificationComponent 构造消息通知
          return MessageNotifactionComponent(
            avatorImage: message['avatorImage']!,
            name: message['name']!,
            messageInfo: message['messageInfo']!,
          );
        },
      ),
    );
  }
}
