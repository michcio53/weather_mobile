import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/injector_container.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/weather_page.dart';

Route<dynamic> weatherRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => BlocProvider(
      create: (_) => injector<WeatherBloc>()..add(WeatherStarted()),
      child: const WeatherPage(),
    ),
  );
}
