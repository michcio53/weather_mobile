import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_page_bottom_navigation_bar.dart';

import '../../../helpers/helpers.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class FakeWeatherStarted extends Fake implements WeatherStarted {}

void main() {
  late MockWeatherBloc mockWeatherBloc;
  late MockNavigator mockNavigator;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    mockNavigator = MockNavigator();
    registerFallbackValue(FakeWeatherStarted());
  });

  testWidgets('renders WeatherPageBottomNavigationBar with correct childrens',
      (tester) async {
    when(() => mockWeatherBloc.state).thenReturn(
      const WeatherState.initial(),
    );

    await tester.pumpApp(
      BlocProvider<WeatherBloc>(
        create: (_) => mockWeatherBloc,
        child: const Material(
          child: WeatherPageBottomNavigationBar(),
        ),
      ),
    );

    expect(find.byType(ConversionSwitch), findsOneWidget);
    expect(find.byType(SearchIconButton), findsOneWidget);
  });

  group(
    'ConversionSwitch',
    () {
      testWidgets(
          'triggers WeatherBloc state if success and user click on button',
          (tester) async {
        when(() => mockWeatherBloc.state).thenReturn(
          const WeatherState.initial()
              .copyWith(weatherStatus: WeatherStatus.success),
        );
        when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

        await tester.pumpApp(
          BlocProvider<WeatherBloc>(
            create: (_) => mockWeatherBloc,
            child: const Material(
              child: ConversionSwitch(),
            ),
          ),
        );

        await tester.pump();
        await tester.tap(find.byType(TextButton));

        verify(() => mockWeatherBloc.add(any())).called(1);
      });

      testWidgets(
          'not triggers WeatherBloc state if loading and user click on button',
          (tester) async {
        when(() => mockWeatherBloc.state).thenReturn(
          const WeatherState.initial()
              .copyWith(weatherStatus: WeatherStatus.loading),
        );
        when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

        await tester.pumpApp(
          BlocProvider<WeatherBloc>(
            create: (_) => mockWeatherBloc,
            child: const Material(
              child: ConversionSwitch(),
            ),
          ),
        );

        await tester.pump();
        await tester.tap(find.byType(TextButton));

        verifyNever(() => mockWeatherBloc.add(any()));
      });
    },
  );

  group('SearchIconButton', () {
    testWidgets('when WeatherStatus.loading on onPressed is Null',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.loading),
      );
      when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: const Material(
            child: SearchIconButton(),
          ),
        ),
      );

      final button = tester.firstWidget<IconButton>(find.byType(IconButton));

      //ignore: prefer_void_to_null
      expect(button.onPressed, isA<Null>());
    });

    testWidgets('when WeatherStatus.loading on onPressed is Function',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.success),
      );
      when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: const Material(
            child: SearchIconButton(),
          ),
        ),
      );

      final button = tester.firstWidget<IconButton>(find.byType(IconButton));

      expect(button.onPressed, isA<Function>());
    });

    testWidgets('when click on IconButton it pushes search page',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.success),
      );
      //ignore: body_might_complete_normally_nullable
      when(() => mockNavigator.pushNamed(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: MockNavigatorProvider(
            navigator: mockNavigator,
            child: const Material(
              child: SearchIconButton(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));

      verify(() => mockNavigator.pushNamed('/search')).called(1);
    });

    testWidgets(
        'when return from previous screen with correct value it pushes event',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.success),
      );
      //ignore: body_might_complete_normally_nullable
      when(() => mockNavigator.pushNamed(any())).thenAnswer((_) async => 123);
      when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: MockNavigatorProvider(
            navigator: mockNavigator,
            child: const Material(
              child: SearchIconButton(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));

      verify(() => mockWeatherBloc.add(any())).called(1);
    });

    testWidgets(
        'when return from previous screen with incorrect value it do nothing',
        (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        const WeatherState.initial()
            .copyWith(weatherStatus: WeatherStatus.success),
      );
      //ignore: body_might_complete_normally_nullable
      when(() => mockNavigator.pushNamed(any())).thenAnswer((_) async => '123');
      when(() => mockWeatherBloc.add(any())).thenAnswer((_) async {});

      await tester.pumpApp(
        BlocProvider<WeatherBloc>(
          create: (_) => mockWeatherBloc,
          child: MockNavigatorProvider(
            navigator: mockNavigator,
            child: const Material(
              child: SearchIconButton(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));

      verifyNever(() => mockWeatherBloc.add(any()));
    });
  });
}
