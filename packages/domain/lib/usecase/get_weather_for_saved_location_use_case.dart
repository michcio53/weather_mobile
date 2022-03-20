import 'package:domain/data_source/weather_data_source.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:domain/store/weather_store.dart';
import 'package:domain/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/fpdarts/try_catch_e.dart';

enum GetWeatherForSavedLocationFailure { unexpected, noWoeid, notFound }

class GetWeatherForSavedLocationUseCase implements UseCase<GetWeatherForSavedLocationFailure, WeatherForPlace> {
  GetWeatherForSavedLocationUseCase({
    required WeatherStore weatherStore,
    required WeatherDataSource weatherDataSource,
  })  : _weatherStore = weatherStore,
        _weatherDataSource = weatherDataSource;

  final WeatherStore _weatherStore;
  final WeatherDataSource _weatherDataSource;

  @override
  TaskEither<GetWeatherForSavedLocationFailure, WeatherForPlace> execute() {
    return _getWeatherWoeid()
        .flatMap(
          (woeid) => _getWeatherForPlace(woeid: woeid),
        )
        .map((result) => result);
  }

  TaskEither<GetWeatherForSavedLocationFailure, int> _getWeatherWoeid() {
    return tryCatchE(() async {
      final result = _weatherStore.getWoeid();
      if (result != null) {
        return right(result);
      } else {
        return left(GetWeatherForSavedLocationFailure.noWoeid);
      }
    }, ((error, stackTrace) => GetWeatherForSavedLocationFailure.unexpected));
  }

  TaskEither<GetWeatherForSavedLocationFailure, WeatherForPlace> _getWeatherForPlace({required int woeid}) {
    return _weatherDataSource
        .getWeatherFromId(woeid.toString())
        .bimap((l) => GetWeatherForSavedLocationFailure.unexpected, (result) => result);
  }
}
