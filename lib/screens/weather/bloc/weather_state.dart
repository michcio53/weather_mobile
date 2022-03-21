part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, failure }

@immutable
class WeatherState extends Equatable {
  const WeatherState({
    this.weatherForPlace,
    required this.weatherStatus,
  });

  WeatherState.initial()
      : weatherForPlace = null,
        weatherStatus = WeatherStatus.initial;

  final WeatherForPlace? weatherForPlace;
  final WeatherStatus weatherStatus;

  WeatherState copyWith({
    WeatherForPlace? weatherForPlace,
    WeatherStatus? weatherStatus,
  }) {
    return WeatherState(
      weatherForPlace: weatherForPlace ?? this.weatherForPlace,
      weatherStatus: weatherStatus ?? this.weatherStatus,
    );
  }

  @override
  List<Object?> get props => [weatherForPlace, weatherStatus];
}
