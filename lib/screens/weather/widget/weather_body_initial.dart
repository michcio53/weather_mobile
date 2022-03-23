import 'package:flutter/material.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/l10n/l10n.dart';

class WeatherBodyInitial extends StatelessWidget {
  const WeatherBodyInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.weatherInitialTitle,
            style: const TextStyle(fontSize: FontSizes.xLarge),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.medium),
          Text(
            context.l10n.weatherInitialSubtitle,
            style: const TextStyle(fontSize: FontSizes.xLarge),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.large),
          Icon(
            Icons.search,
            size: IconSizes.xxLarge.height,
          )
        ],
      ),
    );
  }
}
