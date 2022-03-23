import 'package:domain/domain_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:remote/remote_injector.dart';
import 'package:weather_mobile/env_params.dart';
import 'package:weather_mobile/screens/search/bloc/search_bloc.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

final injector = GetIt.instance;
Future<void> init(EnvParams envParams) async {
  await injector.registerDomain();

  _registerBloc();

  injector.registerRemote(baseUrl: envParams.weatherUrl);
}

void _registerBloc() {
  injector
    ..registerLazySingleton(
      () => WeatherBloc(
        getWeatherForSavedLocationUseCase: injector.get(),
        saveLocationIdUseCase: injector.get(),
      ),
    )
    ..registerFactory(
      () => SearchBloc(
        getLocationsByQueryUseCase: injector.get(),
      ),
    );
}
