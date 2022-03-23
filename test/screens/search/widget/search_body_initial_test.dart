import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/screens/search/widget/serach_body_initial.dart';

import '../../../helpers/helpers.dart';

void main() {
  testWidgets(
    'renders SearchBodyInitial with correct childrens',
    (tester) async {
      await tester.pumpApp(
        const SearchBodyInitial(),
      );

      expect(find.byType(Text), findsOneWidget);
    },
  );
}
