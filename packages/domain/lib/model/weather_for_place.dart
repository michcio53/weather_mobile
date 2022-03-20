import 'package:domain/model/consolidated_weather.dart';
import 'package:flutter/foundation.dart';

class WeatherForPlace {
  const WeatherForPlace({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
    required this.timezone,
    required this.consolidatedWeather,
  });

  final String title;
  final String locationType;
  final int woeid;
  final String lattLong;
  final String timezone;
  final List<ConsolidatedWeather> consolidatedWeather;

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
      consolidatedWeather: consolidatedWeather ?? this.consolidatedWeather,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    // ignore: always_put_control_body_on_new_line
    if (identical(this, other)) return true;

    return other is WeatherForPlace &&
        other.title == title &&
        other.locationType == locationType &&
        other.woeid == woeid &&
        other.lattLong == lattLong &&
        other.timezone == timezone &&
        listEquals(other.consolidatedWeather, consolidatedWeather);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return title.hashCode ^
        locationType.hashCode ^
        woeid.hashCode ^
        lattLong.hashCode ^
        timezone.hashCode ^
        consolidatedWeather.hashCode;
  }
}
