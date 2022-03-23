import 'package:json_annotation/json_annotation.dart';

part 'consolidated_weather_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ConsolidatedWeatherModel {
  const ConsolidatedWeatherModel({
    this.id,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.windDirectionCompass,
    this.created,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.theTemp,
    this.windSpeed,
    this.windDirection,
    this.airPressure,
    this.humidity,
    this.visibility,
    this.predictability,
  });

  factory ConsolidatedWeatherModel.fromJson(Map<String, dynamic> json) => _$ConsolidatedWeatherModelFromJson(json);

  final int? id;
  final String? weatherStateName;
  final String? weatherStateAbbr;
  final String? windDirectionCompass;
  final String? created;
  final String? applicableDate;
  final double? minTemp;
  final double? maxTemp;
  final double? theTemp;
  final double? windSpeed;
  final double? windDirection;
  final double? airPressure;
  final int? humidity;
  final double? visibility;
  final int? predictability;

  Map<String, dynamic> toJson() => _$ConsolidatedWeatherModelToJson(this);
}
