// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsolidatedWeatherModel _$ConsolidatedWeatherModelFromJson(
        Map<String, dynamic> json) =>
    ConsolidatedWeatherModel(
      id: json['id'] as int?,
      weatherStateName: json['weather_state_name'] as String?,
      weatherStateAbbr: json['weather_state_abbr'] as String?,
      windDirectionCompass: json['wind_direction_compass'] as String?,
      created: json['created'] as String?,
      applicableDate: json['applicable_date'] as String?,
      minTemp: (json['min_temp'] as num?)?.toDouble(),
      maxTemp: (json['max_temp'] as num?)?.toDouble(),
      theTemp: (json['the_temp'] as num?)?.toDouble(),
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      windDirection: (json['wind_direction'] as num?)?.toDouble(),
      airPressure: (json['air_pressure'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
      visibility: (json['visibility'] as num?)?.toDouble(),
      predictability: json['predictability'] as int?,
    );

Map<String, dynamic> _$ConsolidatedWeatherModelToJson(
        ConsolidatedWeatherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbr,
      'wind_direction_compass': instance.windDirectionCompass,
      'created': instance.created,
      'applicable_date': instance.applicableDate,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'the_temp': instance.theTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'air_pressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };
