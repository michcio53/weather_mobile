// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_api_client.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$HttpApiClient extends HttpApiClient {
  _$HttpApiClient([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HttpApiClient;

  @override
  Future<Response<WeatherForPlaceModel>> getWeatherForWoeid(
      {required String woeid}) {
    final $url = '/location/${woeid}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<WeatherForPlaceModel, WeatherForPlaceModel>($request);
  }

  @override
  Future<Response<List<LocationModel>>> getLocationByQuery(
      {required String query}) {
    final $url = 'location/search/?query=${query}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<LocationModel>, LocationModel>($request);
  }
}
