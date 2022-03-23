import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

class WeatherBodyFailure extends StatelessWidget {
  const WeatherBodyFailure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.weatherFailureTitle,
            style: context.textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.large),
          Text(
            context.l10n.weatherFailureSubtitle,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.large),
          TextButton(
            onPressed: () => context.read<WeatherBloc>()..add(WeatherStarted()),
            child: Text(context.l10n.weatherFailureButtonTitle),
          )
        ],
      ),
    );
  }
}
