import 'package:domain/model/consolidated_weather.dart';
import 'package:equatable/equatable.dart';

class WeatherForPlace extends Equatable {
  const WeatherForPlace({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
    required this.timezone,
    required this.consolidatedWeather,
    required this.time,
    required this.sunRise,
    required this.sunSet,
  });

  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;
  final String timezone;
  final List<ConsolidatedWeather> consolidatedWeather;
  final DateTime time;
  final DateTime sunRise;
  final DateTime sunSet;

  WeatherForPlace copyWith({
    String? title,
    String? locationType,
    int? woeid,
    String? lattLong,
    String? timezone,
    List<ConsolidatedWeather>? consolidatedWeather,
    DateTime? time,
    DateTime? sunRise,
    DateTime? sunSet,
  }) {
    return WeatherForPlace(
      title: title ?? this.title,
      locationType: locationType ?? this.locationType,
      woeid: woeid ?? this.woeid,
      lattLong: lattLong ?? this.lattLong,
      timezone: timezone ?? this.timezone,
      consolidatedWeather: consolidatedWeather ?? this.consolidatedWeather,
      time: time ?? this.time,
      sunRise: sunRise ?? this.sunRise,
      sunSet: sunSet ?? this.sunSet,
    );
  }

  @override
  List<Object?> get props => [
        title,
        locationType,
        woeid,
        lattLong,
        timezone,
        consolidatedWeather,
      ];
}
