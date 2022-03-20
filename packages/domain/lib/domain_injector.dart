import 'package:domain/preference_assistant/preference_assistant.dart';
import 'package:domain/store/weather_store.dart';
import 'package:domain/usecase/get_locations_by_query_use_case.dart';
import 'package:domain/usecase/get_weather_for_saved_location_use_case.dart';
import 'package:domain/usecase/save_location_id_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension DomainInjector on GetIt {
  Future<void> registerDomain() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    this
      ..registerSingleton(sharedPreferences)
      ..registerFactory(
        () => PreferenceAssistant(
          sharedPreferences: get(),
        ),
      )
      ..registerFactory(
        () => WeatherStore(
          preferenceAssistant: get(),
        ),
      )
      ..registerFactory(
        () => GetLocationsByQueryUseCase(
          weatherDataSource: get(),
        ),
      )
      ..registerFactory(
        () => GetWeatherForSavedLocationUseCase(
          weatherDataSource: get(),
          weatherStore: get(),
        ),
      )
      ..registerFactory(
        () => SaveLocationIdUseCase(
          weatherStore: get(),
        ),
      );
  }
}
