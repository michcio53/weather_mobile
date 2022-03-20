import 'package:domain/model/error_detail.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:fpdart/fpdart.dart';

abstract class WeatherDataSource {
  TaskEither<ErrorDetail, WeatherForPlace> getWeatherFromId(String id);
}
