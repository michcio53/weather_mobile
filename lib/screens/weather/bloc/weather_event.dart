part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherStarted extends WeatherEvent {}

class WeatherConversionChanged extends WeatherEvent {}

class WeatherItemChoosed extends WeatherEvent {
  WeatherItemChoosed({
    required this.woeid,
  });

  final int woeid;
}
