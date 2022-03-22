import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/injector_container.dart';
import 'package:weather_mobile/screens/search/bloc/search_bloc.dart';
import 'package:weather_mobile/screens/search/search_page.dart';

Route<dynamic> searchRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => BlocProvider(
      create: (_) => injector<SearchBloc>(),
      child: SearchPage(),
    ),
  );
}
