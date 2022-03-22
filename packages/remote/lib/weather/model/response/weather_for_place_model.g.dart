// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_for_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForPlaceModel _$WeatherForPlaceModelFromJson(
        Map<String, dynamic> json) =>
    WeatherForPlaceModel(
      title: json['title'] as String,
      locationType: json['location_type'] as String,
      woeid: json['woeid'] as int,
      lattLong: json['latt_long'] as String,
      timezone: json['timezone'] as String,
      time: json['time'] as String,
      sunRise: json['sun_rise'] as String,
      sunSet: json['sun_set'] as String,
      consolidatedWeather: (json['consolidated_weather'] as List<dynamic>)
          .map((e) =>
              ConsolidatedWeatherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherForPlaceModelToJson(
        WeatherForPlaceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattLong,
      'timezone': instance.timezone,
      'time': instance.time,
      'sun_rise': instance.sunRise,
      'sun_set': instance.sunSet,
      'consolidated_weather':
          instance.consolidatedWeather.map((e) => e.toJson()).toList(),
    };
