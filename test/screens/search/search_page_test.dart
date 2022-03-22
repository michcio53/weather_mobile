import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/search/bloc/search_bloc.dart';
import 'package:weather_mobile/screens/search/search_page.dart';
import 'package:weather_mobile/screens/search/widget/search_body_failure.dart';
import 'package:weather_mobile/screens/search/widget/search_body_loading.dart';
import 'package:weather_mobile/screens/search/widget/search_body_success.dart';
import 'package:weather_mobile/screens/search/widget/serach_body_initial.dart';

import '../../helpers/pump_app.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState> implements SearchBloc {}

void main() {
  late MockSearchBloc mockSearchBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
  });

  group('SearchPage', () {
    testWidgets('renders SearchPageBody and SearchPageInput', (tester) async {
      when(() => mockSearchBloc.state).thenReturn(SearchInitial());

      await tester.pumpApp(
        BlocProvider<SearchBloc>(
          create: (_) => mockSearchBloc,
          child: SearchPage(),
        ),
      );

      expect(find.byType(SearchPageBody), findsOneWidget);
      expect(find.byType(SearchPageInput), findsOneWidget);
    });
  });

  group('SearchPageBody', () {
    testWidgets('renders SearchBodyInitial for SearchInitial', (tester) async {
      when(() => mockSearchBloc.state).thenReturn(SearchInitial());

      await tester.pumpApp(
        BlocProvider<SearchBloc>(
          create: (_) => mockSearchBloc,
          child: SearchPageBody(),
        ),
      );

      expect(find.byType(SearchBodyInitial), findsOneWidget);
    });

    testWidgets('renders SearchBodyLoading for SearchBodyLoading', (tester) async {
      when(() => mockSearchBloc.state).thenReturn(SearchLoading());

      await tester.pumpApp(
        BlocProvider<SearchBloc>(
          create: (_) => mockSearchBloc,
          child: SearchPageBody(),
        ),
      );

      expect(find.byType(SearchBodyLoading), findsOneWidget);
    });

    testWidgets('renders SearchBodySuccess for SearchSuccess', (tester) async {
      when(() => mockSearchBloc.state).thenReturn(SearchSuccess(locations: []));

      await tester.pumpApp(
        BlocProvider<SearchBloc>(
          create: (_) => mockSearchBloc,
          child: SearchPageBody(),
        ),
      );

      expect(find.byType(SearchBodySuccess), findsOneWidget);
    });

    testWidgets('renders SearchBodySuccess for SearchFailure', (tester) async {
      when(() => mockSearchBloc.state).thenReturn(SearchFailure());

      await tester.pumpApp(
        BlocProvider<SearchBloc>(
          create: (_) => mockSearchBloc,
          child: SearchPageBody(),
        ),
      );

      expect(find.byType(SearchBodyFailure), findsOneWidget);
    });
  });
}
