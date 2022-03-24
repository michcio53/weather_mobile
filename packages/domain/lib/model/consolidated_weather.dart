import 'package:domain/utils/conversion_util.dart';
import 'package:equatable/equatable.dart';

enum WeatherStateEnum {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  ligtRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
}

class ConsolidatedWeather extends Equatable {
  const ConsolidatedWeather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  final int? id;
  final String? weatherStateName;
  final String? weatherStateAbbr;
  final String? windDirectionCompass;
  final String? created;
  final DateTime? applicableDate;

  /// Min Temp in Celcius
  final double? minTemp;

  /// Max Temp in Celcius
  final double? maxTemp;

  /// Temp in Celcius
  final double? theTemp;

  /// Wind Speed in Mph
  final double? windSpeed;
  final double? windDirection;

  /// Airpressure in mbar
  final double? airPressure;
  final int? humidity;

  /// Visibility in Mph
  final double? visibility;
  final int? predictability;

  double? get theTempFahrenheit => theTemp != null ? celciusToFehrenheit(theTemp!) : null;
  double? get maxTempFahrenheit => maxTemp != null ? celciusToFehrenheit(maxTemp!) : null;
  double? get minTempFahrenheit => minTemp != null ? celciusToFehrenheit(minTemp!) : null;
  double? get windSpeedKm => windSpeed != null ? milesPerHourToKiliometerPerHour(windSpeed!) : null;
  double? get visibilityKm => visibility != null ? milesPerHourToKiliometerPerHour(visibility!) : null;

  WeatherStateEnum? get weatherStateEnum {
    if (weatherStateAbbr != null) {
      switch (weatherStateAbbr) {
        case 'c':
          return WeatherStateEnum.clear;
        case 'h':
          return WeatherStateEnum.hail;
        case 'hc':
          return WeatherStateEnum.heavyCloud;
        case 'hr':
          return WeatherStateEnum.heavyRain;
        case 'lc':
          return WeatherStateEnum.lightCloud;
        case 'lr':
          return WeatherStateEnum.ligtRain;
        case 's':
          return WeatherStateEnum.showers;
        case 'sl':
          return WeatherStateEnum.sleet;
        case 'sn':
          return WeatherStateEnum.snow;
        case 't':
          return WeatherStateEnum.thunderstorm;
        default:
          return null;
      }
    } else {
      return null;
    }
  }

  ConsolidatedWeather copyWith({
    int? id,
    String? weatherStateName,
    String? weatherStateAbbr,
    String? windDirectionCompass,
    String? created,
    DateTime? applicableDate,
    double? minTemp,
    double? maxTemp,
    double? theTemp,
    double? windSpeed,
    double? windDirection,
    double? airPressure,
    int? humidity,
    double? visibility,
    int? predictability,
  }) {
    return ConsolidatedWeather(
      id: id ?? this.id,
      weatherStateName: weatherStateName ?? this.weatherStateName,
      weatherStateAbbr: weatherStateAbbr ?? this.weatherStateAbbr,
      windDirectionCompass: windDirectionCompass ?? this.windDirectionCompass,
      created: created ?? this.created,
      applicableDate: applicableDate ?? this.applicableDate,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      theTemp: theTemp ?? this.theTemp,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      airPressure: airPressure ?? this.airPressure,
      humidity: humidity ?? this.humidity,
      visibility: visibility ?? this.visibility,
      predictability: predictability ?? this.predictability,
    );
  }

  @override
  List<Object?> get props => [
        id,
        weatherStateName,
        weatherStateAbbr,
        windDirectionCompass,
        created,
        applicableDate,
        minTemp,
        maxTemp,
        theTemp,
        windSpeed,
        windDirection,
        airPressure,
        humidity,
        visibility,
        predictability,
      ];
}
