import 'package:flutter/material.dart';
import 'package:weather_mobile/router/app_router.dart';
import 'package:weather_mobile/screens/weather/weather_page.dart';
import 'package:weather_mobile/screens/weather/weather_route.dart';

class AppRouterFactory implements AppRouter {
  @override
  Route route(RouteSettings settings) {
    switch (settings.name) {
      case WeatherPage.routeName:
        return weatherRoute(settings);
      default:
        return _defaultRoute(settings);
    }
  }

  Route<dynamic> _defaultRoute(RouteSettings settings) => MaterialPageRoute(
        settings: settings,
        builder: (context) => const Scaffold(),
      );
}
