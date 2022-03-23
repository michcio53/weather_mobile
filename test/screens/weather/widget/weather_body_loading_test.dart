import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_loading.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders WeatherBodyLoading with correct childrens',
    (tester) async {
      await tester.pumpApp(
        const WeatherBodyLoading(),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
