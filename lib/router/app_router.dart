import 'package:flutter/widgets.dart';

abstract class AppRouter {
  Route<dynamic> route(RouteSettings settings);
}
