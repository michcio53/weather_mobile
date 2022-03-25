import 'package:domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:weather_mobile/screens/search/widget/search_body_success.dart';

import '../../../helpers/helpers.dart';

void main() {
  late MockNavigator mockNavigator;

  setUp(() {
    mockNavigator = MockNavigator();
  });

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

  testWidgets(
    'when click on ListTile it pops page with location woeid',
    (tester) async {
      await tester.pumpApp(
        Material(
          child: MockNavigatorProvider(
            navigator: mockNavigator,
            child: SearchBodySuccess(
              locations: locations,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));

      verify(() => mockNavigator.pop(123)).called(1);
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
