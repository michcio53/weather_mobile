import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/widget/weather_body_failure.dart';
import 'package:weather_mobile/screens/widget/weather_body_loading.dart';
import 'package:weather_mobile/screens/widget/weather_body_succes.dart';
import 'package:weather_mobile/screens/widget/weather_page_bottom_navigation_bar.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  static const String routeName = '/weather';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherPageBody(),
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
            return const SizedBox();
          case WeatherStatus.loading:
            return WeatherBodyLoading();
          case WeatherStatus.success:
            final weatherForPlace = state.weatherForPlace;
            final consolidatedWeather = weatherForPlace?.consolidatedWeather;

            if (weatherForPlace != null && consolidatedWeather != null) {
              return WeatherBodySuccess(
                weatherForPlace: weatherForPlace,
                consolidatedWeather: consolidatedWeather,
                unitsEnum: state.unitsEnum,
              );
            } else {
              return SizedBox();
            }
          case WeatherStatus.failure:
            return WeatherBodyFailure();
        }
      },
    );
  }
}