import 'package:domain/data_source/weather_data_source.dart';
import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:domain/store/weather_store.dart';
import 'package:domain/usecase/get_weather_for_saved_location_use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockWeatherStore extends Mock implements WeatherStore {}

class MockWeatherDataSource extends Mock implements WeatherDataSource {}

void main() {
  late GetWeatherForSavedLocationUseCase getWeatherForSavedLocationUseCase;
  late MockWeatherStore mockWeatherStore;
  late MockWeatherDataSource mockWeatherDataSource;

  setUp(() {
    mockWeatherStore = MockWeatherStore();
    mockWeatherDataSource = MockWeatherDataSource();

    getWeatherForSavedLocationUseCase = GetWeatherForSavedLocationUseCase(
      weatherStore: mockWeatherStore,
      weatherDataSource: mockWeatherDataSource,
    );
  });

  test('Given correct parameters it invokes every method in usecase and returns weather model', () async {
    when(() => mockWeatherDataSource.getWeatherFromId(any())).thenAnswer(
      (invocation) => TaskEither.right(weatherForPlace),
    );

    when(() => mockWeatherStore.getWoeid()).thenReturn(123);

    final result = await getWeatherForSavedLocationUseCase.execute().run();

    verify(() => mockWeatherStore.getWoeid()).called(1);
    verify(() => mockWeatherDataSource.getWeatherFromId(any())).called(1);

    result.fold(
      (l) => throw Exception(l.toString()),
      (r) => expect(r, weatherForPlace),
    );
  });

  test(
      'Given ErrorDetailFatal to WeatherDataSource it returns GetWeatherForSavedLocationFailure.unexpected and invokes every method in use case',
      () async {
    when(() => mockWeatherDataSource.getWeatherFromId(any())).thenAnswer(
      (invocation) => TaskEither.left(const ErrorDetailFatal()),
    );

    when(() => mockWeatherStore.getWoeid()).thenReturn(123);

    final result = await getWeatherForSavedLocationUseCase.execute().run();

    verify(() => mockWeatherStore.getWoeid()).called(1);
    verify(() => mockWeatherDataSource.getWeatherFromId(any())).called(1);

    result.fold((exceptionDetail) => expect(exceptionDetail, GetWeatherForSavedLocationFailure.unexpected), (r) {});
  });

  test(
      'Given null to getWoeid it returns GetWeatherForSavedLocationFailure.noWoeid and invokes only getWoeid method in use case',
      () async {
    when(() => mockWeatherDataSource.getWeatherFromId(any())).thenAnswer(
      (invocation) => TaskEither.right(weatherForPlace),
    );

    when(() => mockWeatherStore.getWoeid()).thenReturn(null);

    final result = await getWeatherForSavedLocationUseCase.execute().run();

    verify(() => mockWeatherStore.getWoeid()).called(1);
    verifyNever(() => mockWeatherDataSource.getWeatherFromId(any()));

    result.fold((exceptionDetail) => expect(exceptionDetail, GetWeatherForSavedLocationFailure.noWoeid), (r) {});
  });
}

final weatherForPlace = WeatherForPlace(
  title: 'title',
  locationType: 'locationType',
  woeid: 123,
  lattLong: 'lattLong',
  timezone: 'timezone',
  consolidatedWeather: const [
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
  sunRise: DateTime.now(),
  sunSet: DateTime.now(),
  time: DateTime.now(),
);
