import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_initial.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders WeatherBodyInitial with correct childrens',
    (tester) async {
      await tester.pumpApp(
        const  WeatherBodyInitial(),
      );

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(Icon), findsNWidgets(1));
    },
  );
}
