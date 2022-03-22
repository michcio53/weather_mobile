import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:domain/usecase/get_weather_for_saved_location_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

class MockGetWeatherForSavedLocationUseCase extends Mock implements GetWeatherForSavedLocationUseCase {}

void main() {
  late WeatherBloc bloc;
  late MockGetWeatherForSavedLocationUseCase mockGetWeatherForSavedLocationUseCase;

  setUp(() {
    mockGetWeatherForSavedLocationUseCase = MockGetWeatherForSavedLocationUseCase();
    bloc = WeatherBloc(getWeatherForSavedLocationUseCase: mockGetWeatherForSavedLocationUseCase);
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
      WeatherState.initial().copyWith(weatherStatus: WeatherStatus.loading),
      WeatherState.initial().copyWith(weatherStatus: WeatherStatus.success, weatherForPlace: weatherForPlace),
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
      WeatherState.initial().copyWith(weatherStatus: WeatherStatus.loading),
      WeatherState.initial().copyWith(weatherStatus: WeatherStatus.failure),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'On double WeatherConversionChanged emits UnitsEnum.imperial and then UnitsEnum.metric',
    build: () => bloc,
    act: (bloc) {
      bloc.add(WeatherConversionChanged());
      bloc.add(WeatherConversionChanged());
    },
    expect: () => [
      WeatherState.initial().copyWith(unitsEnum: UnitsEnum.imperial),
      WeatherState.initial().copyWith(unitsEnum: UnitsEnum.metric),
    ],
  );
}

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
