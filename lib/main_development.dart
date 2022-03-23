// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:weather_mobile/app/app.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/bootstrap.dart';
import 'package:weather_mobile/env_params.dart';
import 'package:weather_mobile/router/app_router_factory.dart';

void main() {
  bootstrap(
    envParams: const EnvParams(
      weatherUrl: 'https://www.metaweather.com/api',
    ),
    builder: () => App(
      appRouterFactory: AppRouterFactory(),
      appTheme: AppTheme(),
    ),
  );
}
