part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

enum UnitsEnum { imperial, metric }

@immutable
class WeatherState extends Equatable {
  const WeatherState({
    required this.weatherStatus,
    required this.unitsEnum,
    this.weatherForPlace,
  });

  const WeatherState.initial()
      : weatherForPlace = null,
        weatherStatus = WeatherStatus.initial,
        unitsEnum = UnitsEnum.metric;

  final WeatherForPlace? weatherForPlace;
  final WeatherStatus weatherStatus;
  final UnitsEnum unitsEnum;

  bool get isWeatherDataNotEmpty {
    final consolidatedWeather = weatherForPlace?.consolidatedWeather;
    return weatherForPlace != null &&
        consolidatedWeather != null &&
        consolidatedWeather.isNotEmpty;
  }

  bool get isLoading => weatherStatus == WeatherStatus.loading;

  WeatherState copyWith({
    WeatherForPlace? weatherForPlace,
    WeatherStatus? weatherStatus,
    UnitsEnum? unitsEnum,
  }) {
    return WeatherState(
      weatherForPlace: weatherForPlace ?? this.weatherForPlace,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      unitsEnum: unitsEnum ?? this.unitsEnum,
    );
  }

  @override
  List<Object?> get props => [weatherForPlace, weatherStatus, unitsEnum];
}
