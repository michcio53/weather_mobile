import 'package:chopper/chopper.dart' as chopper;
import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/location.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/http_api_client.dart';
import 'package:remote/weather/mapper/location_mapper.dart';
import 'package:remote/weather/mapper/weather_for_place_mapper.dart';
import 'package:remote/weather/model/response/consolidated_weather_model.dart';
import 'package:remote/weather/model/response/location_model.dart';
import 'package:remote/weather/model/response/weather_for_place_model.dart';
import 'package:remote/weather/weather_data_source_impl.dart';
import 'package:test/test.dart';

class MockWeatherForPlaceMapper extends Mock implements WeatherForPlaceMapper {}

class MockLocationMapper extends Mock implements LocationMapper {}

class MockHttpApiClient extends Mock implements HttpApiClient {}

class MockResponseWeatherForPlaceModelResult extends Mock implements chopper.Response<WeatherForPlaceModel> {}

class MockResponseLocationResult extends Mock implements chopper.Response<List<LocationModel>> {}

// class MockLocationModel extends Mock implements chopper.Response<LocationModel> {}

// ignore: avoid_implementing_value_types
class FakeWeatherForPlace extends Fake implements WeatherForPlace {}

class FakeWeatherForPlaceModel extends Fake implements WeatherForPlaceModel {}

// ignore: avoid_implementing_value_types
class FakeLocation extends Fake implements Location {}

class FakeLocationModel extends Fake implements LocationModel {}

void main() {
  late WeatherDataSourceImpl source;
  late MockWeatherForPlaceMapper mockWeatherForPlaceMapper;
  late MockLocationMapper mockLocationMapper;
  late MockHttpApiClient mockHttpApiClient;

  setUpAll(
    () {
      registerFallbackValue(FakeWeatherForPlace());
      registerFallbackValue(FakeWeatherForPlaceModel());
      registerFallbackValue(FakeLocation());
      registerFallbackValue(FakeLocationModel());
    },
  );

  setUp(() {
    mockWeatherForPlaceMapper = MockWeatherForPlaceMapper();
    mockLocationMapper = MockLocationMapper();
    mockHttpApiClient = MockHttpApiClient();
    source = WeatherDataSourceImpl(
      httpApiClient: mockHttpApiClient,
      weatherForPlaceMapper: mockWeatherForPlaceMapper,
      locationMapper: mockLocationMapper,
    );
  });

  group('Weather for Place', () {
    test('Given correct parameters it returns a weather model', () async {
      final mockResponseWeatherForPlaceModelResult = MockResponseWeatherForPlaceModelResult();

      when(() => mockResponseWeatherForPlaceModelResult.body).thenReturn(weatherForPlaceModel);

      when(() => mockWeatherForPlaceMapper.map(any())).thenReturn(weatherForPlace);

      when(() => mockHttpApiClient.getWeatherForWoeid(woeid: any(named: 'woeid')))
          .thenAnswer((invocation) => Future.value(mockResponseWeatherForPlaceModelResult));

      final result = await source.getWeatherFromId('123').run();

      verify(() => mockHttpApiClient.getWeatherForWoeid(woeid: any(named: 'woeid'))).called(1);

      result.match(
        (error) => throw Exception('$error'),
        (weather) => expect(
          weather,
          weatherForPlace,
        ),
      );
    });

    test('Given exception was raised it returns ErrorDetails.fatal with exception and stacktrace', () async {
      final mockResponseWeatherForPlaceModelResult = MockResponseWeatherForPlaceModelResult();

      when(() => mockResponseWeatherForPlaceModelResult.body).thenReturn(weatherForPlaceModel);

      when(() => mockWeatherForPlaceMapper.map(any())).thenReturn(weatherForPlace);

      final exception = Exception('fatal');
      when(() => mockHttpApiClient.getWeatherForWoeid(woeid: any(named: 'woeid'))).thenThrow(exception);

      final result = await source.getWeatherFromId('123').run();

      verify(() => mockHttpApiClient.getWeatherForWoeid(woeid: any(named: 'woeid'))).called(1);

      result.match(
        (exceptionDetail) => expect(exceptionDetail.throwable, exception),
        (weather) => {},
      );
    });

    test('Given null body it returns ErrorDetails.fatal', () async {
      final mockResponseWeatherForPlaceModelResult = MockResponseWeatherForPlaceModelResult();

      when(() => mockResponseWeatherForPlaceModelResult.body).thenReturn(null);

      when(() => mockWeatherForPlaceMapper.map(any())).thenReturn(weatherForPlace);

      when(() => mockHttpApiClient.getWeatherForWoeid(woeid: any(named: 'woeid')))
          .thenAnswer((invocation) => Future.value(mockResponseWeatherForPlaceModelResult));

      final result = await source.getWeatherFromId('123').run();

      verify(() => mockHttpApiClient.getWeatherForWoeid(woeid: any(named: 'woeid'))).called(1);

      result.match(
        (exceptionDetail) => expect(exceptionDetail, ErrorDetailFatal()),
        (weather) => {},
      );
    });
  });

  group(
    'Location',
    () {
      test('Given correct parameters it returns a weather model', () async {
        final mockResponseLocationResult = MockResponseLocationResult();

        when(() => mockResponseLocationResult.body).thenReturn([locationModel]);

        when(() => mockLocationMapper.map(any())).thenReturn(location);

        when(() => mockHttpApiClient.getLocationByQuery(query: any(named: 'query')))
            .thenAnswer((invocation) => Future.value(mockResponseLocationResult));

        final result = await source.getLocationByQuery('123').run();

        verify(() => mockHttpApiClient.getLocationByQuery(query: any(named: 'query'))).called(1);

        result.match(
          (error) => throw Exception('$error'),
          (receivedLocation) => expect(
            receivedLocation,
            [location],
          ),
        );
      });

      test('Given exception was raised it returns ErrorDetails.fatal with exception and stacktrace', () async {
        final mockResponseLocationResult = MockResponseLocationResult();

        when(() => mockResponseLocationResult.body).thenReturn([locationModel]);

        when(() => mockLocationMapper.map(any())).thenReturn(location);

        final exception = Exception('fatal');
        when(() => mockHttpApiClient.getLocationByQuery(query: any(named: 'query'))).thenThrow(exception);

        final result = await source.getLocationByQuery('123').run();

        verify(() => mockHttpApiClient.getLocationByQuery(query: any(named: 'query'))).called(1);

        result.match(
          (exceptionDetail) => expect(exceptionDetail.throwable, exception),
          (weather) => {},
        );
      });

      test('Given null body it returns ErrorDetails.fatal', () async {
        final mockResponseLocationResult = MockResponseLocationResult();

        when(() => mockResponseLocationResult.body).thenReturn([locationModel]);

        when(() => mockLocationMapper.map(any())).thenReturn(location);

        when(() => mockHttpApiClient.getLocationByQuery(query: any(named: 'query')))
            .thenAnswer((invocation) => Future.value(mockResponseLocationResult));

        final result = await source.getLocationByQuery('123').run();

        verify(() => mockHttpApiClient.getLocationByQuery(query: any(named: 'query'))).called(1);

        result.match(
          (exceptionDetail) => expect(exceptionDetail, ErrorDetailFatal()),
          (weather) => {},
        );
      });
    },
  );
}

const weatherForPlaceModel = WeatherForPlaceModel(
  title: 'title',
  locationType: 'locationType',
  woeid: 123,
  lattLong: 'lattLong',
  timezone: 'timezone',
  consolidatedWeather: [
    ConsolidatedWeatherModel(
      id: 123,
      weatherStateName: 'weatherStateName',
      weatherStateAbbr: 'weatherStateAbbr',
      windDirectionCompass: 'windDirectionCompass',
      created: 'created',
      applicableDate: 'applicableDate',
      minTemp: 1.2,
      maxTemp: 1.2,
      theTemp: 1.2,
      windSpeed: 1.2,
      windDirection: 1.2,
      airPressure: 1.2,
      humidity: 1,
      visibility: 1.2,
      predictability: 1,
    ),
  ],
);

const weatherForPlace = WeatherForPlace(
  title: 'title',
  locationType: 'locationType',
  woeid: 123,
  lattLong: 'lattLong',
  timezone: 'timezone',
  consolidatedWeather: [
    ConsolidatedWeather(
      id: 123,
      weatherStateName: 'weatherStateName',
      weatherStateAbbr: 'weatherStateAbbr',
      windDirectionCompass: 'windDirectionCompass',
      created: 'created',
      applicableDate: 'applicableDate',
      minTemp: 1.2,
      maxTemp: 1.2,
      theTemp: 1.2,
      windSpeed: 1.2,
      windDirection: 1.2,
      airPressure: 1.2,
      humidity: 1,
      visibility: 1.2,
      predictability: 1,
    ),
  ],
);

const locationModel = LocationModel(
  title: 'title',
  locationType: 'locationType',
  lattLong: 'lattLong',
  woeid: 123,
);

const location = Location(
  title: 'title',
  locationType: 'locationType',
  lattLong: 'lattLong',
  woeid: 123,
);
