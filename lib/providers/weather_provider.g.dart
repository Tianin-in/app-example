// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherImpl _$$WeatherImplFromJson(Map<String, dynamic> json) =>
    _$WeatherImpl(
      weather: json['weather'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      temperature: json['temperature'] as String,
      winddirection: json['winddirection'] as String?,
      windpower: json['windpower'] as String?,
      humidity: json['humidity'] as String?,
      reporttime: json['reporttime'] == null
          ? null
          : DateTime.parse(json['reporttime'] as String),
      temperatureFloat: json['temperatureFloat'] as String?,
      humidityFloat: json['humidityFloat'] as String?,
      adcode: json['adcode'] as String?,
    );

Map<String, dynamic> _$$WeatherImplToJson(_$WeatherImpl instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'city': instance.city,
      'province': instance.province,
      'temperature': instance.temperature,
      'winddirection': instance.winddirection,
      'windpower': instance.windpower,
      'humidity': instance.humidity,
      'reporttime': instance.reporttime?.toIso8601String(),
      'temperatureFloat': instance.temperatureFloat,
      'humidityFloat': instance.humidityFloat,
      'adcode': instance.adcode,
    };
