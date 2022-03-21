import 'package:bloc/bloc.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:domain/usecase/get_weather_for_saved_location_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required GetWeatherForSavedLocationUseCase getWeatherForSavedLocationUseCase,
  })  : _getWeatherForSavedLocationUseCase = getWeatherForSavedLocationUseCase,
        super(WeatherState.initial()) {
    on<WeatherStarted>((event, emit) async {
      await _onWeatherStarted(event, emit);
    });
  }

  final GetWeatherForSavedLocationUseCase _getWeatherForSavedLocationUseCase;

  Future<void> _onWeatherStarted(
    WeatherStarted event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));
    await _getWeatherForSavedLocationUseCase
        .execute()
        .match(
          (failure) => emit(state.copyWith(weatherStatus: WeatherStatus.failure)),
          (result) => emit(
            state.copyWith(
              weatherForPlace: result,
              weatherStatus: WeatherStatus.success,
            ),
          ),
        )
        .run();
  }
}
