import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'weather_provider.freezed.dart';
part 'weather_provider.g.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required String weather,
    required String city,
    required String province,
    required String temperature,
    String? winddirection,
    String? windpower,
    String? humidity,
    DateTime? reporttime,
    String? temperatureFloat,
    String? humidityFloat,
    String? adcode,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, Weather?>((ref) {
  final dio = Dio(); // 创建 Dio 实例
  return WeatherNotifier(dio); // 返回 WeatherNotifier 实例
});

// 网络请求相关常量
const String weatherApiUrl =
    'https://restapi.amap.com/v3/weather/weatherInfo'; // 替换为您的API UR
const String apiKey =
    'key=e077c5fb591c03e2dc80124efe3c5593&extensions=base&output=JSON&'; // 您的API密钥（如果有）

// WeatherNotifier 负责管理 Weather 状态并从网络请求获取天气数据
class WeatherNotifier extends StateNotifier<Weather?> {
  final Dio _dio;

  // 构造函数中注入 Dio 实例（用于网络请求）
  WeatherNotifier(this._dio) : super(null);

  // 获取天气信息并更新状态
  Future<void> fetchWeather(String city) async {
    city = "city" + "=$city";
    print("$weatherApiUrl?$apiKey$city");
    try {
      // 构建请求URL（假设API接受city作为查询参数）
      final response = await _dio.get(
        '$weatherApiUrl?$apiKey$city',
      );

      // 根据返回的JSON数据构建Weather对象并更新状态
      state = Weather.fromJson(response.data["lives"][0]);

      print(state);
    } catch (e) {
      print('Error fetching weather: $e');
      // 请求失败时可以设置为null或显示错误状态
      state = null;
    }
  }
}
