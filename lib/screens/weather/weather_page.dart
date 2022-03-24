import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_failure.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_initial.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_loading.dart';
import 'package:weather_mobile/screens/weather/widget/weather_body_succes.dart';
import 'package:weather_mobile/screens/weather/widget/weather_page_bottom_navigation_bar.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  static const String routeName = '/weather';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: WeatherPageBody(),
      ),
      bottomNavigationBar: WeatherPageBottomNavigationBar(),
    );
  }
}

class WeatherPageBody extends StatelessWidget {
  const WeatherPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        switch (state.weatherStatus) {
          case WeatherStatus.initial:
            return const WeatherBodyInitial();
          case WeatherStatus.loading:
            return const WeatherBodyLoading();
          case WeatherStatus.success:
            if (state.isWeatherDataNotEmpty) {
              return WeatherBodySuccess(
                weatherForPlace: state.weatherForPlace!,
                consolidatedWeather: state.weatherForPlace!.consolidatedWeather,
                unitsEnum: state.unitsEnum,
              );
            } else {
              return const WeatherBodyFailure();
            }
          case WeatherStatus.failure:
            return const WeatherBodyFailure();
        }
      },
    );
  }
}
