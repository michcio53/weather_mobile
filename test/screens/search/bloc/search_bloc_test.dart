import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/location.dart';
import 'package:domain/usecase/get_locations_by_query_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_mobile/screens/search/bloc/search_bloc.dart';

class MockGetLocationsByQueryUseCase extends Mock
    implements GetLocationsByQueryUseCase {}

void main() {
  late SearchBloc bloc;
  late MockGetLocationsByQueryUseCase mockGetLocationsByQueryUseCase;

  setUp(() {
    mockGetLocationsByQueryUseCase = MockGetLocationsByQueryUseCase();
    bloc = SearchBloc(
      getLocationsByQueryUseCase: mockGetLocationsByQueryUseCase,
    );
  });

  blocTest<SearchBloc, SearchState>(
    'On SearchTyped emits SearchLoading and SearchSuccess with location',
    build: () => bloc,
    wait: const Duration(milliseconds: 300),
    act: (bloc) {
      bloc.add(SearchTyped(query: 'query'));
    },
    setUp: () {
      when(
        () =>
            mockGetLocationsByQueryUseCase.execute(param: any(named: 'param')),
      ).thenAnswer(
        (_) => TaskEither.right(
          [location],
        ),
      );
    },
    verify: (bloc) {
      verify(
        () => mockGetLocationsByQueryUseCase.execute(
          param: any(named: 'param'),
        ),
      ).called(1);
    },
    expect: () => [
      SearchLoading(),
      const SearchSuccess(locations: [location]),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'On SearchTyped and with returbubg failure it emits SearchLoading and SearchFailure',
    build: () => bloc,
    wait: const Duration(milliseconds: 300),
    act: (bloc) {
      bloc.add(SearchTyped(query: 'query'));
    },
    setUp: () {
      when(
        () =>
            mockGetLocationsByQueryUseCase.execute(param: any(named: 'param')),
      ).thenAnswer(
        (_) => TaskEither.left(
          GetLocationsByQueryUseCaseFailure.unexpected,
        ),
      );
    },
    verify: (bloc) {
      verify(
        () => mockGetLocationsByQueryUseCase.execute(
          param: any(named: 'param'),
        ),
      ).called(1);
    },
    expect: () => [
      SearchLoading(),
      SearchFailure(),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'On SearchTyped with empty query emits SearchInitial',
    build: () => bloc,
    wait: const Duration(milliseconds: 300),
    act: (bloc) {
      bloc.add(SearchTyped(query: ''));
    },
    setUp: () {
      when(
        () => mockGetLocationsByQueryUseCase.execute(
          param: any(named: 'param'),
        ),
      ).thenAnswer(
        (_) => TaskEither.right(
          [location],
        ),
      );
    },
    verify: (bloc) {
      verifyNever(
        () => mockGetLocationsByQueryUseCase.execute(
          param: any(named: 'param'),
        ),
      );
    },
    expect: () => [
      SearchInitial(),
    ],
  );
}

const location = Location(
  title: 'title',
  locationType: 'locationType',
  lattLong: 'lattLong',
  woeid: 123,
);
