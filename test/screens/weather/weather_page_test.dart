import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/weather_page.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_failure.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_loading.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_succes.dart';
import 'package:weather_mobile/screens/weather/widget/weather_page_bottom_navigation_bar.dart';

import '../../helpers/pump_app.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  group('WeatherPage', () {
    testWidgets('renders WeatherPageBody and WeatherPageBottomNavigationBar',
        (tester) async {
      when(() => mockWeatherBloc.state)
          .thenReturn(const WeatherState.initial());

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: WeatherPage(),
        ),
      );

      expect(find.byType(WeatherPageBody), findsOneWidget);
      expect(find.byType(WeatherPageBottomNavigationBar), findsOneWidget);
    });
  });

  group('WeatherPageBody', () {
    testWidgets('renders SizedBox for WeatherStatus.initial', (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.initial));

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: WeatherPageBody(),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders WeatherBodyLoading for WeatherStatus.loading',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.loading));

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: WeatherPageBody(),
        ),
      );

      expect(find.byType(WeatherBodyLoading), findsOneWidget);
    });

    testWidgets(
        'renders SizedBox for  WeatherStatus.success and null weatherForPlace with null consolidatedWeather',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(const WeatherState.initial()
          .copyWith(weatherStatus: WeatherStatus.success));

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: WeatherPageBody(),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets(
        'renders WeatherBodySuccess for  WeatherStatus.success and not null weatherForPlace with not null consolidatedWeather',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial().copyWith(
          weatherStatus: WeatherStatus.success,
          weatherForPlace: weatherForPlace,
        ),
      );

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: WeatherPageBody(),
        ),
      );

      expect(find.byType(WeatherBodySuccess), findsOneWidget);
    });

    testWidgets('renders WeatherBodyFailure for  WeatherStatus.failure',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial().copyWith(
          weatherStatus: WeatherStatus.failure,
        ),
      );

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: WeatherPageBody(),
        ),
      );

      expect(find.byType(WeatherBodyFailure), findsOneWidget);
    });
  });
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
