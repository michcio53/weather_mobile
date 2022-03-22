import 'package:bloc/bloc.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:domain/usecase/get_weather_for_saved_location_use_case.dart';
import 'package:domain/usecase/save_location_id_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required GetWeatherForSavedLocationUseCase getWeatherForSavedLocationUseCase,
    required SaveLocationIdUseCase saveLocationIdUseCase,
  })  : _getWeatherForSavedLocationUseCase = getWeatherForSavedLocationUseCase,
        _saveLocationIdUseCase = saveLocationIdUseCase,
        super(const WeatherState.initial()) {
    on<WeatherStarted>((event, emit) async {
      await _onWeatherStarted(event, emit);
    });
    on<WeatherConversionChanged>((event, emit) async {
      _onWeatherConversionChanged(event, emit);
    });
    on<WeatherItemChoosed>((event, emit) async {
      _mapWeatherItemChoosedd(event, emit);
    });
  }

  final GetWeatherForSavedLocationUseCase _getWeatherForSavedLocationUseCase;
  final SaveLocationIdUseCase _saveLocationIdUseCase;

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

  void _onWeatherConversionChanged(WeatherConversionChanged event, Emitter<WeatherState> emit) {
    final nextUnitIndex = (state.unitsEnum.index + 1) % UnitsEnum.values.length;
    final changedUnit = UnitsEnum.values[nextUnitIndex];

    emit(state.copyWith(unitsEnum: changedUnit));
  }

  Future<void> _mapWeatherItemChoosedd(WeatherItemChoosed event, Emitter<WeatherState> emit) async {
    await _saveLocationIdUseCase.execute(param: event.woeid).run();
    add(WeatherStarted());
  }
}
