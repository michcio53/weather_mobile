class ConsolidatedWeather {
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

  final int id;
  final String weatherStateName;
  final String weatherStateAbbr;
  final String windDirectionCompass;
  final String created;
  final String applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;

  ConsolidatedWeather copyWith({
    int? id,
    String? weatherStateName,
    String? weatherStateAbbr,
    String? windDirectionCompass,
    String? created,
    String? applicableDate,
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
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    // ignore: always_put_control_body_on_new_line
    if (identical(this, other)) return true;

    return other is ConsolidatedWeather &&
        other.id == id &&
        other.weatherStateName == weatherStateName &&
        other.weatherStateAbbr == weatherStateAbbr &&
        other.windDirectionCompass == windDirectionCompass &&
        other.created == created &&
        other.applicableDate == applicableDate &&
        other.minTemp == minTemp &&
        other.maxTemp == maxTemp &&
        other.theTemp == theTemp &&
        other.windSpeed == windSpeed &&
        other.windDirection == windDirection &&
        other.airPressure == airPressure &&
        other.humidity == humidity &&
        other.visibility == visibility &&
        other.predictability == predictability;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return id.hashCode ^
        weatherStateName.hashCode ^
        weatherStateAbbr.hashCode ^
        windDirectionCompass.hashCode ^
        created.hashCode ^
        applicableDate.hashCode ^
        minTemp.hashCode ^
        maxTemp.hashCode ^
        theTemp.hashCode ^
        windSpeed.hashCode ^
        windDirection.hashCode ^
        airPressure.hashCode ^
        humidity.hashCode ^
        visibility.hashCode ^
        predictability.hashCode;
  }
}
