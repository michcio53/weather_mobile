import 'package:domain/model/consolidated_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_overview.dart';
import 'package:weather_mobile/utils/format_util.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group(
    'WeatherOverview',
    () {
      testWidgets('renders WeatherOverview with correct childrens',
          (tester) async {
        await tester.pumpApp(
          WeatherOverview(
            consolidatedWeather: consolidatedWeather,
            unitsEnum: UnitsEnum.metric,
          ),
        );

        expect(
          find.byType(WeatherOverviewSingleTile),
          findsNWidgets(consolidatedWeather.length),
        );
      });
    },
  );

  group('WeatherOverviewSingleTile', () {
    testWidgets('renders WeatherOverviewSingleTile with correct childrens',
        (tester) async {
      await tester.pumpApp(
        WeatherOverviewSingleTile(
          singleConsolidatedWeather: consolidatedWeather.first,
          unitsEnum: UnitsEnum.metric,
        ),
      );

      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets(
        'renders WeatherOverviewSingleTile with correct values for metrics',
        (tester) async {
      final singleConsolidatedWeather = consolidatedWeather.first;

      await tester.pumpApp(
        WeatherOverviewSingleTile(
          singleConsolidatedWeather: singleConsolidatedWeather,
          unitsEnum: UnitsEnum.metric,
        ),
      );

      final maxTempWidget = tester.firstWidget<Text>(
        find.byKey(
          const ValueKey('WeatherOverviewSingleTile_highTemp_text'),
        ),
      );
      final minTempWidget = tester.firstWidget<Text>(
        find.byKey(
          const ValueKey('WeatherOverviewSingleTile_lowTemp_text'),
        ),
      );
      final tempWidget = tester.firstWidget<Text>(
        find.byKey(
          const ValueKey('WeatherOverviewSingleTile_temp_text'),
        ),
      );

      expect(
        maxTempWidget.data,
        'H: ${singleConsolidatedWeather.maxTemp?.oneDigitAfterComa()}',
      );
      expect(
        minTempWidget.data,
        'L: ${singleConsolidatedWeather.minTemp?.oneDigitAfterComa()}',
      );
      expect(
        tempWidget.data,
        'Avg: ${singleConsolidatedWeather.theTemp?.oneDigitAfterComa()}',
      );
    });

    testWidgets(
        'renders WeatherOverviewSingleTile with correct values for imperial',
        (tester) async {
      final singleConsolidatedWeather = consolidatedWeather.first;

      await tester.pumpApp(
        WeatherOverviewSingleTile(
          singleConsolidatedWeather: singleConsolidatedWeather,
          unitsEnum: UnitsEnum.imperial,
        ),
      );

      final maxTempWidget = tester.firstWidget<Text>(
        find.byKey(
          const ValueKey('WeatherOverviewSingleTile_highTemp_text'),
        ),
      );
      final minTempWidget = tester.firstWidget<Text>(
        find.byKey(
          const ValueKey('WeatherOverviewSingleTile_lowTemp_text'),
        ),
      );
      final tempWidget = tester.firstWidget<Text>(
        find.byKey(
          const ValueKey('WeatherOverviewSingleTile_temp_text'),
        ),
      );

      expect(
        maxTempWidget.data,
        'H: ${singleConsolidatedWeather.maxTempFahrenheit?.oneDigitAfterComa()}',
      );
      expect(
        minTempWidget.data,
        'L: ${singleConsolidatedWeather.minTempFahrenheit?.oneDigitAfterComa()}',
      );
      expect(
        tempWidget.data,
        'Avg: ${singleConsolidatedWeather.theTempFahrenheit?.oneDigitAfterComa()}',
      );
    });

    testWidgets(
        'renders WeatherOverviewSingleTile without icon values if its incorrect',
        (tester) async {
      final singleConsolidatedWeather = consolidatedWeather.last;

      await tester.pumpApp(
        WeatherOverviewSingleTile(
          singleConsolidatedWeather: singleConsolidatedWeather,
          unitsEnum: UnitsEnum.imperial,
        ),
      );

      expect(find.byType(SvgPicture), findsNothing);
    });
  });
}

final consolidatedWeather = [
  ConsolidatedWeather(
    id: 123,
    weatherStateName: 'weatherStateName',
    weatherStateAbbr: 's',
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
];
