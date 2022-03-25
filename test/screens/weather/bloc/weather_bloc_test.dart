import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:domain/usecase/get_weather_for_saved_location_use_case.dart';
import 'package:domain/usecase/save_location_id_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

class MockGetWeatherForSavedLocationUseCase extends Mock
    implements GetWeatherForSavedLocationUseCase {}

class MockSaveLocationIdUseCase extends Mock implements SaveLocationIdUseCase {}

void main() {
  late WeatherBloc bloc;
  late MockGetWeatherForSavedLocationUseCase
      mockGetWeatherForSavedLocationUseCase;
  late MockSaveLocationIdUseCase mockSaveLocationIdUseCase;

  setUp(() {
    mockGetWeatherForSavedLocationUseCase =
        MockGetWeatherForSavedLocationUseCase();
    mockSaveLocationIdUseCase = MockSaveLocationIdUseCase();
    bloc = WeatherBloc(
      getWeatherForSavedLocationUseCase: mockGetWeatherForSavedLocationUseCase,
      saveLocationIdUseCase: mockSaveLocationIdUseCase,
    );
  });

  blocTest<WeatherBloc, WeatherState>(
    'On WeatherStarted emits WeatherStatus.success and not null weatherForPlace',
    build: () => bloc,
    act: (bloc) {
      bloc.add(WeatherStarted());
    },
    setUp: () {
      when(() => mockGetWeatherForSavedLocationUseCase.execute()).thenAnswer(
        (_) => TaskEither.right(weatherForPlace),
      );
    },
    verify: (bloc) {
      verify(() => mockGetWeatherForSavedLocationUseCase.execute()).called(1);
    },
    expect: () => [
      const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.loading),
      const WeatherState.initial().copyWith(
        weatherStatus: WeatherStatus.success,
        weatherForPlace: weatherForPlace,
      ),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'On WeatherStarted emits WeatherStatus.failure when failure from useCase',
    build: () => bloc,
    act: (bloc) {
      bloc.add(WeatherStarted());
    },
    setUp: () {
      when(() => mockGetWeatherForSavedLocationUseCase.execute()).thenAnswer(
        (_) => TaskEither.left(GetWeatherForSavedLocationFailure.unexpected),
      );
    },
    verify: (bloc) {
      verify(() => mockGetWeatherForSavedLocationUseCase.execute()).called(1);
    },
    expect: () => [
      const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.loading),
      const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.failure),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'On double WeatherConversionChanged emits UnitsEnum.imperial and then UnitsEnum.metric',
    build: () => bloc,
    act: (bloc) {
      bloc
        ..add(WeatherConversionChanged())
        ..add(WeatherConversionChanged());
    },
    expect: () => [
      const WeatherState.initial().copyWith(unitsEnum: UnitsEnum.imperial),
      const WeatherState.initial().copyWith(unitsEnum: UnitsEnum.metric),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'On WeatherItemChoosed emits WeatherStatus.loading and then  WeatherStatus.success with weatherForPlace',
    build: () => bloc,
    act: (bloc) {
      bloc.add(WeatherItemChoosed(woeid: 123));
    },
    verify: (bloc) {
      verify(
        () => mockSaveLocationIdUseCase.execute(
          param: any(named: 'param'),
        ),
      ).called(1);
    },
    setUp: () {
      when(
        () => mockSaveLocationIdUseCase.execute(
          param: any(named: 'param'),
        ),
      ).thenAnswer(
        (_) => TaskEither.right(unit),
      );
      when(() => mockGetWeatherForSavedLocationUseCase.execute()).thenAnswer(
        (_) => TaskEither.right(weatherForPlace),
      );
    },
    expect: () => [
      const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.loading),
      const WeatherState.initial().copyWith(
        weatherStatus: WeatherStatus.success,
        weatherForPlace: weatherForPlace,
      )
    ],
  );
}

final weatherForPlace = WeatherForPlace(
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
      applicableDate: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
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
