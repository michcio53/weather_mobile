import 'package:domain/domain_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:remote/remote_injector.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

final injector = GetIt.instance;
Future<void> init() async {
  await injector.registerDomain();

  _registerBloc();

  injector..registerRemote(baseUrl: '');
}

void _registerBloc() {
  injector
    ..registerLazySingleton(
      () => WeatherBloc(
        getWeatherForSavedLocationUseCase: injector.get(),
      ),
    );
}
