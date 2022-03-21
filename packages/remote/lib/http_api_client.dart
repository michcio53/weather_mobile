import 'package:dio/dio.dart';
import 'package:remote/weather/model/response/location_model.dart';
import 'package:remote/weather/model/response/weather_for_place_model.dart';
import 'package:retrofit/retrofit.dart';

part 'http_api_client.g.dart';

@RestApi()
abstract class HttpApiClient {
  factory HttpApiClient(Dio dio) = _HttpApiClient;

  @GET('/location/{woeid}/')
  Future<WeatherForPlaceModel> getWeatherForWoeid(
    @Path() String woeid,
  );

  @GET('location/search/?query={query}')
  Future<List<LocationModel>> getLocationByQuery(
    @Path() String query,
  );
}
