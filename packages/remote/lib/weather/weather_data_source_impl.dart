import 'package:domain/data_source/weather_data_source.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/fpdarts/try_catch_e.dart';
import 'package:remote/http_api_client.dart';
import 'package:remote/weather/mapper/weather_for_place_mapper.dart';

class WeatherDataSourceImpl implements WeatherDataSource {
  WeatherDataSourceImpl({
    required HttpApiClient httpApiClient,
    required WeatherForPlaceMapper weatherForPlaceMapper,
  })  : _httpApiClient = httpApiClient,
        _weatherForPlaceMapper = weatherForPlaceMapper;

  final HttpApiClient _httpApiClient;
  final WeatherForPlaceMapper _weatherForPlaceMapper;

  @override
  TaskEither<ErrorDetail, WeatherForPlace> getWeatherFromId(String id) {
    return tryCatchE<ErrorDetail, WeatherForPlace>(
      () async {
        final response = await _httpApiClient.getWeatherForWoeid(woeid: id);

        final body = response.body;
        if (body != null) {
          final mappedWeather = _weatherForPlaceMapper.map(body);
          return right(mappedWeather);
        } else {
          return left(ErrorDetailFatal());
        }
      },
      (error, stackTrace) => ErrorDetailFatal(
        throwable: error,
        stackTrace: stackTrace,
      ),
    );
  }
}
