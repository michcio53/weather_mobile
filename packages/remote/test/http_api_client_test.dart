import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/http_api_client.dart';
import 'package:remote/weather/model/response/location_model.dart';
import 'package:remote/weather/model/response/weather_for_place_model.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    registerFallbackValue(FakeRequestOptions());
  });

  test(
    'Given correct parameters it returns correct location model',
    () async {
      when(() => mockDio.options).thenReturn(BaseOptions());

      when(() => mockDio.fetch<List<dynamic>>(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '', baseUrl: ''),
          data: [location],
        ),
      );

      final apiClient = HttpApiClient(mockDio);

      final result = await apiClient.getLocationByQuery('query');

      expect(result, [locationModel]);
    },
  );

  test(
    'Given correct parameters it returns correct WeatherForPlace Model',
    () async {
      when(() => mockDio.options).thenReturn(BaseOptions());

      when(() => mockDio.fetch<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '', baseUrl: ''),
          data: weatherForPlace,
        ),
      );

      final apiClient = HttpApiClient(mockDio);

      final result = await apiClient.getWeatherForWoeid('query');

      expect(result, weatherForPlaceModel);
    },
  );
}

final location = <String, dynamic>{
  "title": "New York",
  "location_type": "City",
  "woeid": 2459115,
  "latt_long": "40.71455,-74.007118",
};

const locationModel = LocationModel(
  title: "New York",
  locationType: "City",
  lattLong: "40.71455,-74.007118",
  woeid: 2459115,
);

final weatherForPlace = <String, dynamic>{
  "title": "New York",
  "location_type": "City",
  "woeid": 2459115,
  "latt_long": "40.71455,-74.007118",
  "timezone": "US/Eastern",
  "time": "2022-03-23T02:32:24.690752-04:00",
  "sun_rise": "2022-03-23T06:54:24.114949-04:00",
  "sun_set": "2022-03-23T19:11:23.285215-04:00",
  "consolidated_weather": []
};

const weatherForPlaceModel = WeatherForPlaceModel(
  title: "New York",
  locationType: "City",
  woeid: 2459115,
  lattLong: "40.71455,-74.007118",
  timezone: "US/Eastern",
  time: "2022-03-23T02:32:24.690752-04:00",
  sunRise: "2022-03-23T06:54:24.114949-04:00",
  sunSet: "2022-03-23T19:11:23.285215-04:00",
  consolidatedWeather: [],
);
