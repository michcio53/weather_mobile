import 'package:chopper/chopper.dart' as chopper;
import 'package:chopper/chopper.dart';
import 'package:remote/weather/model/response/weather_for_place_model.dart';

part 'http_api_client.chopper.dart';

@ChopperApi()
abstract class HttpApiClient extends ChopperService {
  static HttpApiClient create({required ChopperClient client}) {
    return _$HttpApiClient(client);
  }

  @Get(path: '/location/{woeid}/')
  Future<chopper.Response<WeatherForPlaceModel>> getWeatherForWoeid({
    @Path('woeid') required String woeid,
  });
}
