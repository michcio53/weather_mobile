import 'package:domain/data_source/weather_data_source.dart';
import 'package:domain/model/location.dart';
import 'package:domain/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/task_either.dart';

enum GetLocationsByQueryUseCaseFailure { unexpected, empty }

class GetLocationsByQueryUseCase extends ParamUseCase<
    GetLocationsByQueryUseCaseFailure, List<Location>, String> {
  GetLocationsByQueryUseCase({
    required WeatherDataSource weatherDataSource,
  }) : _weatherDataSource = weatherDataSource;

  final WeatherDataSource _weatherDataSource;

  @override
  TaskEither<GetLocationsByQueryUseCaseFailure, List<Location>> execute(
      {required String param}) {
    return _weatherDataSource.getLocationByQuery(param).bimap(
        (_) => GetLocationsByQueryUseCaseFailure.unexpected,
        (result) => result);
  }
}
