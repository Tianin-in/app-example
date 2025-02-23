class MessageNotifactionModel {
  final String avatorImage;
  final String name;
  final String messageInfo;

  MessageNotifactionModel({
    required this.avatorImage,
    required this.name,
    required this.messageInfo,
  });

  // 可选：添加一个工厂构造函数，用于从 JSON 数据创建模型实例
  factory MessageNotifactionModel.fromJson(Map<String, dynamic> json) {
    return MessageNotifactionModel(
      avatorImage: json['avatorImage'],
      name: json['name'],
      messageInfo: json['messageInfo'],
    );
  }

  // 可选：添加一个方法，用于将模型实例转换为 JSON 数据
  Map<String, dynamic> toJson() {
    return {
      'avatorImage': avatorImage,
      'name': name,
      'messageInfo': messageInfo,
    };
  }
}
