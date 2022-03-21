import 'package:domain/data_source/weather_data_source.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/location.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/fpdarts/try_catch_e.dart';
import 'package:remote/http_api_client.dart';
import 'package:remote/weather/mapper/location_mapper.dart';
import 'package:remote/weather/mapper/weather_for_place_mapper.dart';

class WeatherDataSourceImpl implements WeatherDataSource {
  WeatherDataSourceImpl({
    required HttpApiClient httpApiClient,
    required WeatherForPlaceMapper weatherForPlaceMapper,
    required LocationMapper locationMapper,
  })  : _httpApiClient = httpApiClient,
        _weatherForPlaceMapper = weatherForPlaceMapper,
        _locationMapper = locationMapper;

  final HttpApiClient _httpApiClient;
  final WeatherForPlaceMapper _weatherForPlaceMapper;
  final LocationMapper _locationMapper;

  @override
  TaskEither<ErrorDetail, WeatherForPlace> getWeatherFromId(String id) {
    return tryCatchE<ErrorDetail, WeatherForPlace>(
      () async {
        final response = await _httpApiClient.getWeatherForWoeid(id);

        final mappedWeather = _weatherForPlaceMapper.map(response);
        return right(mappedWeather);
      },
      (error, stackTrace) {
        return ErrorDetailFatal(
          throwable: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  @override
  TaskEither<ErrorDetail, List<Location>> getLocationByQuery(String query) {
    return tryCatchE(
      () async {
        final response = await _httpApiClient.getLocationByQuery(query);

        final mappedLocation = response.map(_locationMapper.map).toList();
        return right(mappedLocation);
      },
      (error, stackTrace) => ErrorDetailFatal(
        throwable: error,
        stackTrace: stackTrace,
      ),
    );
  }
}
