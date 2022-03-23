import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/search/widget/search_body_loading.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders CircularProgressIndicator with correct childrens',
    (tester) async {
      await tester.pumpApp(
        const SearchBodyLoading(),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
