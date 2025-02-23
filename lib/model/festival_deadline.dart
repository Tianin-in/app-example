class FestivalDeadlineModel {
  final String festivalName;
  final String data;
  final String imageUrl;
  final int festivalState;

  FestivalDeadlineModel({
    required this.festivalName,
    required this.data,
    required this.imageUrl,
    required this.festivalState,
  });

  // 可选：添加一个工厂构造函数，用于从 JSON 数据创建模型实例
  factory FestivalDeadlineModel.fromJson(Map<String, dynamic> json) {
    return FestivalDeadlineModel(
      festivalName: json['festivalName'],
      data: json['data'],
      imageUrl: json['imageUrl'],
      festivalState: json['festivalState'],
    );
  }

  // 可选：添加一个方法，用于将模型实例转换为 JSON 数据
  Map<String, dynamic> toJson() {
    return {
      'festivalName': festivalName,
      'data': data,
      'imageUrl': imageUrl,
      'festivalState': festivalState,
    };
  }
}
