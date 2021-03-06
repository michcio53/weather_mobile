import 'package:bloc/bloc.dart';
import 'package:domain/model/location.dart';
import 'package:domain/usecase/get_locations_by_query_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required GetLocationsByQueryUseCase getLocationsByQueryUseCase,
  })  : _getLocationsByQueryUseCase = getLocationsByQueryUseCase,
        super(SearchInitial()) {
    on<SearchTyped>(
      (event, emit) async => _mapSearchTyped(event, emit),
      transformer: debounce(_duration),
    );
  }

  final GetLocationsByQueryUseCase _getLocationsByQueryUseCase;

  Future<void> _mapSearchTyped(
    SearchTyped event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isNotEmpty) {
      emit(SearchLoading());
      await _getLocationsByQueryUseCase
          .execute(param: event.query)
          .match(
            (_) => emit(SearchFailure()),
            (result) => emit(
              SearchSuccess(locations: result),
            ),
          )
          .run();
    } else {
      emit(SearchInitial());
    }
  }
}
