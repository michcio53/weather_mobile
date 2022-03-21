import 'package:domain/model/consolidated_weather.dart';
import 'package:equatable/equatable.dart';

class WeatherForPlace extends Equatable {
  const WeatherForPlace({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
    required this.timezone,
    required List<ConsolidatedWeather> consolidatedWeather,
  }) : _consolidatedWeather = consolidatedWeather;

  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;
  final String timezone;
  final List<ConsolidatedWeather> _consolidatedWeather;

  WeatherForPlace copyWith({
    String? title,
    String? locationType,
    int? woeid,
    String? lattLong,
    String? timezone,
    List<ConsolidatedWeather>? consolidatedWeather,
  }) {
    return WeatherForPlace(
      title: title ?? this.title,
      locationType: locationType ?? this.locationType,
      woeid: woeid ?? this.woeid,
      lattLong: lattLong ?? this.lattLong,
      timezone: timezone ?? this.timezone,
      consolidatedWeather: consolidatedWeather ?? this._consolidatedWeather,
    );
  }

  @override
  List<Object?> get props => [
        title,
        locationType,
        woeid,
        lattLong,
        timezone,
        _consolidatedWeather,
      ];
}
