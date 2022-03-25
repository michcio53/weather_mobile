import 'package:domain/data_source/weather_data_source.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/location.dart';
import 'package:domain/usecase/get_locations_by_query_use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockWeatherDataSource extends Mock implements WeatherDataSource {}

void main() {
  late GetLocationsByQueryUseCase getLocationsByQueryUseCase;
  late MockWeatherDataSource mockWeatherDataSource;

  setUp(() {
    mockWeatherDataSource = MockWeatherDataSource();
    getLocationsByQueryUseCase =
        GetLocationsByQueryUseCase(weatherDataSource: mockWeatherDataSource);
  });

  test(
      'Given correct parameters it invokes every method in usecase and returns locations list',
      () async {
    when(() => mockWeatherDataSource.getLocationByQuery(any())).thenAnswer(
      (_) => TaskEither.right(
        [location],
      ),
    );

    final result =
        await getLocationsByQueryUseCase.execute(param: 'param').run();

    verify(
      () => mockWeatherDataSource.getLocationByQuery(any()),
    ).called(1);

    result.fold(
      (l) => throw Exception(l.toString()),
      (r) => expect(r, [location]),
    );
  });

  test(
      'Given ErrorDetailFatal to WeatherDataSource it returns GetWeatherForSavedLocationFailure.unexpected and invokes every method in use case',
      () async {
    when(() => mockWeatherDataSource.getLocationByQuery(any())).thenAnswer(
      (_) => TaskEither.left(const ErrorDetailFatal()),
    );

    final result =
        await getLocationsByQueryUseCase.execute(param: 'param').run();

    verify(
      () => mockWeatherDataSource.getLocationByQuery(any()),
    ).called(1);

    result.fold(
      (exceptionDetail) => expect(
        exceptionDetail,
        GetLocationsByQueryUseCaseFailure.unexpected,
      ),
      (_) {},
    );
  });
}

const location = Location(
  title: 'title',
  locationType: 'locationType',
  lattLong: 'lattLong',
  woeid: 123,
);
