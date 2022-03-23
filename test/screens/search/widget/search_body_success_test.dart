import 'package:domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/search/widget/search_body_success.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders SearchBodySuccess with correct childrens',
    (tester) async {
      await tester.pumpApp(
        Material(
          child: SearchBodySuccess(
            locations: locations,
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);

      final listViewWidget = tester.firstWidget<ListView>(find.byType(ListView));

      expect(listViewWidget.childrenDelegate.estimatedChildCount, locations.length);
    },
  );
}

final locations = [
  const Location(
    lattLong: 'lattLong',
    locationType: 'locationType',
    title: 'title',
    woeid: 123,
  ),
];
