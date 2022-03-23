import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_failure.dart';

import '../../../helpers/helpers.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState> implements WeatherBloc {}

class FakeWeatherStarted extends Fake implements WeatherStarted {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    registerFallbackValue(FakeWeatherStarted());
  });

  testWidgets(
    'renders WeatherBodyFailure with correct childrens',
    (tester) async {
      await tester.pumpApp(
        const WeatherBodyFailure(),
      );

      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(TextButton), findsNWidgets(1));
    },
  );

  testWidgets('triggers WeatherBloc on tap to refresh', (tester) async {
    when(() => mockWeatherBloc.state).thenReturn(
      const WeatherState.initial(),
    );
    when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

    await tester.pumpApp(
      BlocProvider<WeatherBloc>(
        create: (_) => mockWeatherBloc,
        child: const WeatherBodyFailure(),
      ),
    );

     await tester.pumpAndSettle();
     await tester.tap(find.byType(TextButton));
     verify(() => mockWeatherBloc.add(any())).called(1);
  });
}
