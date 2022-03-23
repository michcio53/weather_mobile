// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/router/app_router_factory.dart';
import 'package:weather_mobile/screens/weather/weather_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.appTheme,
    required this.appRouterFactory,
  }) : super(key: key);

  final AppTheme appTheme;
  final AppRouterFactory appRouterFactory;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: appTheme.theme(LightPalette()),
      dark: appTheme.theme(DarkPalette()),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateRoute: appRouterFactory.route,
          initialRoute: WeatherPage.routeName,
        );
      },
    );
  }
}
