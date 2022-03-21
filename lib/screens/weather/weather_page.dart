import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  static const String routeName = '/weather';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WeatherBloc>().state;
    return Scaffold();
  }
}
