import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

import 'package:weather_mobile/screens/weather/widget/weather_body_succes.dart';
import 'package:weather_mobile/utils/format_util.dart';

import '../../../helpers/helpers.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class FakeWeatherStarted extends Fake implements WeatherStarted {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    registerFallbackValue(FakeWeatherStarted());
  });

  group(
    'WeatherBodySuccess',
    () {
      testWidgets(
        'renders WeatherBodySuccess with correct childrens',
        (tester) async {
          await tester.pumpApp(
            WeatherBodySuccess(
              consolidatedWeather: [consolidatedWeather],
              unitsEnum: UnitsEnum.metric,
              weatherForPlace: weatherForPlace,
            ),
          );

          expect(find.byType(SliverList), findsOneWidget);
          expect(find.byType(SliverGrid), findsOneWidget);
          expect(find.byType(HighLowTemperatureRow), findsOneWidget);
          expect(
            find.byKey(
              const ValueKey(
                'WeatherBodySuccess_weatherForPlaceTitle_text',
              ),
            ),
            findsOneWidget,
          );
          expect(
            find.byKey(
              const ValueKey(
                'WeatherBodySuccess_weatherForPlaceWeatherStateName_text',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders WeatherBodySuccess with correct texts',
        (tester) async {
          await tester.pumpApp(
            WeatherBodySuccess(
              consolidatedWeather: [consolidatedWeather],
              unitsEnum: UnitsEnum.metric,
              weatherForPlace: weatherForPlace,
            ),
          );

          final titleWidget = tester.firstWidget<Text>(
            find.byKey(
              const ValueKey('WeatherBodySuccess_weatherForPlaceTitle_text'),
            ),
          );
          expect(titleWidget.data, weatherForPlace.title);

          final weatherStateNameWidget = tester.firstWidget<Text>(
            find.byKey(
              const ValueKey(
                'WeatherBodySuccess_weatherForPlaceWeatherStateName_text',
              ),
            ),
          );
          expect(
            weatherStateNameWidget.data,
            consolidatedWeather.weatherStateName,
          );
        },
      );

      testWidgets(
        'triggers WeatherBloc on pull to refresh',
        (tester) async {
          when(() => mockWeatherBloc.state).thenReturn(
            const WeatherState.initial(),
          );
          when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

          await tester.pumpApp(
            BlocProvider<WeatherBloc>(
              create: (_) => mockWeatherBloc,
              child: WeatherBodySuccess(
                consolidatedWeather: [consolidatedWeather],
                unitsEnum: UnitsEnum.metric,
                weatherForPlace: weatherForPlace,
              ),
            ),
          );

          await tester.pump();

          await tester.fling(
            find.byKey(
              const ValueKey('WeatherBodySuccess_weatherForPlaceTitle_text'),
            ),
            const Offset(0, 700),
            1000,
          );
          await tester.pump(
            const Duration(seconds: 1),
          ); // finish the scroll animation
          await tester.pump(
            const Duration(
              seconds: 1,
            ),
          ); // finish the indicator settle animation
          await tester.pump(
            const Duration(
              seconds: 1,
            ),
          ); // finish the indicator hide animation

          verify(() => mockWeatherBloc.add(any())).called(1);
        },
      );
    },
  );

  group('HighLowTemperatureRow', () {
    testWidgets(
      'renders HighLowTemperatureRow with correct text in metric units',
      (tester) async {
        await tester.pumpApp(
          HighLowTemperatureRow(
            unitsEnum: UnitsEnum.metric,
            maxTemp: consolidatedWeather.maxTemp!,
            minTemp: consolidatedWeather.minTemp!,
          ),
        );

        final maxTempWidget = tester.firstWidget<Text>(
          find.byKey(
            const ValueKey('HighLowTemperatureRow_displayedMaxTemp_text'),
          ),
        );
        expect(
          maxTempWidget.data,
          'H: ${consolidatedWeather.maxTemp?.oneDigitAfterComa()} ??C',
        );

        final minTempWidget = tester.firstWidget<Text>(
          find.byKey(
            const ValueKey('HighLowTemperatureRow_displayedMinTemp_text'),
          ),
        );
        expect(
          minTempWidget.data,
          'L: ${consolidatedWeather.minTemp?.oneDigitAfterComa()} ??C',
        );
      },
    );

    testWidgets(
      'renders HighLowTemperatureRow with correct text in imperial units',
      (tester) async {
        await tester.pumpApp(
          HighLowTemperatureRow(
            unitsEnum: UnitsEnum.imperial,
            maxTemp: consolidatedWeather.maxTempFahrenheit!.oneDigitAfterComa(),
            minTemp: consolidatedWeather.minTempFahrenheit!.oneDigitAfterComa(),
          ),
        );

        final maxTempWidget = tester.firstWidget<Text>(
          find.byKey(
            const ValueKey('HighLowTemperatureRow_displayedMaxTemp_text'),
          ),
        );
        expect(
          maxTempWidget.data,
          'H: ${consolidatedWeather.maxTempFahrenheit?.oneDigitAfterComa()} ??F',
        );

        final minTempWidget = tester.firstWidget<Text>(
          find.byKey(
            const ValueKey('HighLowTemperatureRow_displayedMinTemp_text'),
          ),
        );
        expect(
          minTempWidget.data,
          'L: ${consolidatedWeather.minTempFahrenheit?.oneDigitAfterComa()} ??F',
        );
      },
    );
  });
}

final consolidatedWeather = ConsolidatedWeather(
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
);

final weatherForPlace = WeatherForPlace(
  title: 'title',
  locationType: 'locationType',
  woeid: 123,
  lattLong: 'lattLong',
  timezone: 'timezone',
  consolidatedWeather: [
    consolidatedWeather,
  ],
  sunRise: DateTime.now(),
  sunSet: DateTime.now(),
  time: DateTime.now(),
);
