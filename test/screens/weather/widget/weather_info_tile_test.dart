import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_info_tile.dart';
import 'package:weather_mobile/utils/format_util.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders WeatherInfoTile.time for passed values',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.time(
          sunRise: sunrise,
          sunSet: sunset,
        ),
      );

      final sunRiseWidget = tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileTime_sunRise_text')));
      expect(sunRiseWidget.data, sunrise.toTimeString());

      final sunSetWidget = tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileTime_sunSet_text')));
      expect(sunSetWidget.data, sunset.toTimeString());

      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(Icon), findsNWidgets(2));
      expect(find.byType(WeatherInfoTileTime), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.wind for passed values with UnitsEnum.metric',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.wind(
          windSpeedKm: windSpeedKm,
          unitsEnum: UnitsEnum.metric,
          windDirectionCompass: 'E',
          windSpeedMph: windSpeedMph,
        ),
      );

      final windDirectionWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileWind_windDirectionCompass_text')));
      expect(windDirectionWidget.data, 'E');

      final windSpeedWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileWinde_windSpeed_text')));
      expect(windSpeedWidget.data, '$windSpeedKm km/hr');

      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTileWind), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.wind for passed values with UnitsEnum.imperial',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.wind(
          windSpeedKm: windSpeedKm,
          unitsEnum: UnitsEnum.imperial,
          windDirectionCompass: 'E',
          windSpeedMph: windSpeedMph,
        ),
      );

      final windDirectionWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileWind_windDirectionCompass_text')));
      expect(windDirectionWidget.data, 'E');

      final windSpeedWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileWinde_windSpeed_text')));
      expect(windSpeedWidget.data, '$windSpeedMph mi/h');

      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTileWind), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.humidity for passed values with UnitsEnum.imperial',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.humidity(
          humidityInPercentage: 12,
        ),
      );

      final humidityInPercentageWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileHumidity_humidityInPercentage_text')));
      expect(humidityInPercentageWidget.data, '12 %');

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTileHumidity), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.visibility for passed values with UnitsEnum.metric',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.visibility(
          unitsEnum: UnitsEnum.metric,
          visiblityMph: visibilityMph,
          visiblityKm: visibilityKm,
        ),
      );

      final visibilityWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileVisibility_visibility_text')));
      expect(visibilityWidget.data, '$visibilityKm km');

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTileVisibility), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.visibility for passed values with UnitsEnum.imperial',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.visibility(
          unitsEnum: UnitsEnum.imperial,
          visiblityMph: visibilityMph,
          visiblityKm: visibilityKm,
        ),
      );

      final visibilityWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileVisibility_visibility_text')));
      expect(visibilityWidget.data, '$visibilityMph miles');

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTileVisibility), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.airPressure for passed values',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.airPressure(
          airPressureInMbar: airPressureInMbar,
        ),
      );

      final airPressureWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTileAirPressure_airPressureInMbar_text')));
      expect(airPressureWidget.data, '$airPressureInMbar hPa');

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTileAirPressure), findsOneWidget);
    },
  );

  testWidgets(
    'renders WeatherInfoTile.predictability for passed values',
    (tester) async {
      await tester.pumpApp(
        WeatherInfoTile.predictability(
          predictabilityInPercentage: predictabilityInPercentage,
        ),
      );

      final predictablilityWidget =
          tester.firstWidget<Text>(find.byKey(const ValueKey('weatherInfoTilePredictability_predictabilityInPercentage_text')));
      expect(predictablilityWidget.data, '$predictabilityInPercentage %');

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(WeatherInfoTilePredictability), findsOneWidget);
    },
  );
}

final sunrise = DateTime.parse('2022-03-23T02:32:24.690752-04:00');
final sunset = DateTime.parse('2022-03-23T06:54:24.114949-04:00');
const windSpeedKm = 1.1;
const windSpeedMph = 2.1;
const visibilityKm = 1.1;
const visibilityMph = 2.1;
const airPressureInMbar = 2.2;
const predictabilityInPercentage = 21;
