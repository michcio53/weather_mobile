import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/search/widget/search_body_failure.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders SearchBodyFailure with correct childrens',
    (tester) async {
      await tester.pumpApp(
        const SearchBodyFailure(),
      );

      expect(find.byType(Text), findsOneWidget);
    },
  );
}
