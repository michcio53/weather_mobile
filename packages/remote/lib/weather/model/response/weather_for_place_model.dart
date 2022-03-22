import 'package:json_annotation/json_annotation.dart';
import 'package:remote/weather/model/response/consolidated_weather_model.dart';

part 'weather_for_place_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class WeatherForPlaceModel {
  const WeatherForPlaceModel({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
    required this.timezone,
    required this.consolidatedWeather,
  });

  factory WeatherForPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForPlaceModelFromJson(json);

  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;
  final String timezone;
  final List<ConsolidatedWeatherModel> consolidatedWeather;

  Map<String, dynamic> toJson() => _$WeatherForPlaceModelToJson(this);
}
