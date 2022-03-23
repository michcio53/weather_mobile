import 'package:flutter/material.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/utils/format_util.dart';

class WeatherInfoTile extends StatelessWidget {
  WeatherInfoTile.time({
    Key? key,
    required DateTime sunRise,
    required DateTime sunSet,
  })  : child = WeatherInfoTileTime(
          sunRise: sunRise,
          sunSet: sunSet,
        ),
        super(key: key);

  WeatherInfoTile.wind({
    Key? key,
    required double windSpeedKm,
    required double windSpeedMph,
    required String windDirectionCompass,
    required UnitsEnum unitsEnum,
  })  : child = WeatherInfoTileWind(
          windSpeedKm: windSpeedKm,
          windSpeedMph: windSpeedMph,
          windDirectionCompass: windDirectionCompass,
          unitsEnum: unitsEnum,
        ),
        super(key: key);

  WeatherInfoTile.humidity({
    Key? key,
    required int humidityInPercentage,
  })  : child = WeatherInfoTileHumidity(
          humidityInPercentage: humidityInPercentage,
        ),
        super(key: key);

  WeatherInfoTile.visibility({
    Key? key,
    required double visiblityKm,
    required double visiblityMph,
    required UnitsEnum unitsEnum,
  })  : child = WeatherInfoTileVisibility(
          visiblityKm: visiblityKm,
          visiblityMph: visiblityMph,
          unitsEnum: unitsEnum,
        ),
        super(key: key);

  WeatherInfoTile.airPressure({
    Key? key,
    required double airPressureInMbar,
  })  : child = WeatherInfoTileAirPressure(
          airPressureInMbar: airPressureInMbar,
        ),
        super(key: key);

  WeatherInfoTile.predictability({
    Key? key,
    required int predictabilityInPercentage,
  })  : child = WeatherInfoTilePredictability(
          predictabilityInPercentage: predictabilityInPercentage,
        ),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: child,
      ),
    );
  }
}

class WeatherInfoTileTime extends StatelessWidget {
  const WeatherInfoTileTime({
    Key? key,
    required this.sunRise,
    required this.sunSet,
  }) : super(key: key);

  final DateTime sunRise;
  final DateTime sunSet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.sunny),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.sunrise),
            ),
          ],
        ),
        const SizedBox(height: Insets.xSmall),
        Text(
          sunRise.toTimeString(),
          key: const ValueKey('weatherInfoTileTime_sunRise_text'),
          style: const TextStyle(
            fontSize: FontSizes.xLarge,
          ),
        ),
        const SizedBox(height: Insets.large),
        Row(
          children: [
            const Icon(Icons.bedtime),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.sunset),
            ),
          ],
        ),
        const SizedBox(height: Insets.xSmall),
        Text(
          sunSet.toTimeString(),
          key: const ValueKey('weatherInfoTileTime_sunSet_text'),
          style: const TextStyle(
            fontSize: FontSizes.xLarge,
          ),
        ),
      ],
    );
  }
}

class WeatherInfoTileWind extends StatelessWidget {
  const WeatherInfoTileWind({
    Key? key,
    required this.windSpeedKm,
    required this.windSpeedMph,
    required this.windDirectionCompass,
    required this.unitsEnum,
  }) : super(key: key);

  final double windSpeedKm;
  final double windSpeedMph;
  final String windDirectionCompass;
  final UnitsEnum unitsEnum;

  String _windSpeed(BuildContext context) {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return context.l10n.milesPerHourSuffix(windSpeedMph.roundToOneDigitAfterComa());
      case UnitsEnum.metric:
        return context.l10n.kmPerHourSuffix(windSpeedKm.roundToOneDigitAfterComa());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.air),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.wind),
            ),
          ],
        ),
        const SizedBox(height: Insets.large),
        Text(
          windDirectionCompass,
          key: const ValueKey('weatherInfoTileWind_windDirectionCompass_text'),
          style: const TextStyle(fontSize: FontSizes.xxLarge),
        ),
        const SizedBox(height: Insets.large),
        Text(
          _windSpeed(context),
          key: const ValueKey('weatherInfoTileWinde_windSpeed_text'),
          style: const TextStyle(fontSize: FontSizes.large),
        )
      ],
    );
  }
}

class WeatherInfoTileHumidity extends StatelessWidget {
  const WeatherInfoTileHumidity({
    Key? key,
    required this.humidityInPercentage,
  }) : super(key: key);

  final int humidityInPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.water),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.humidity),
            ),
          ],
        ),
        const SizedBox(height: Insets.large),
        Center(
          child: Text(
            context.l10n.percentage(humidityInPercentage),
            key: const ValueKey('weatherInfoTileHumidity_humidityInPercentage_text'),
            style: const TextStyle(fontSize: FontSizes.xxLarge),
          ),
        ),
      ],
    );
  }
}

class WeatherInfoTileVisibility extends StatelessWidget {
  const WeatherInfoTileVisibility({
    Key? key,
    required this.visiblityKm,
    required this.visiblityMph,
    required this.unitsEnum,
  }) : super(key: key);

  final double visiblityKm;
  final double visiblityMph;
  final UnitsEnum unitsEnum;

  String _visibility(BuildContext context) {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return context.l10n.milesSuffix(visiblityMph.roundToOneDigitAfterComa());
      case UnitsEnum.metric:
        return context.l10n.kmSuffix(visiblityKm.roundToOneDigitAfterComa());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.visibility),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.humidity),
            ),
          ],
        ),
        const SizedBox(height: Insets.large),
        Text(
          _visibility(context),
          key: const ValueKey('weatherInfoTileVisibility_visibility_text'),
          style: const TextStyle(fontSize: FontSizes.xxLarge),
        )
      ],
    );
  }
}

class WeatherInfoTileAirPressure extends StatelessWidget {
  const WeatherInfoTileAirPressure({
    Key? key,
    required this.airPressureInMbar,
  }) : super(key: key);

  final double airPressureInMbar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.speed),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.airPressure),
            ),
          ],
        ),
        const SizedBox(height: Insets.large),
        Center(
          child: Text(
            context.l10n.hectopascalSuffix(airPressureInMbar),
            key: const ValueKey('weatherInfoTileAirPressure_airPressureInMbar_text'),
            style: const TextStyle(fontSize: FontSizes.xxLarge),
          ),
        )
      ],
    );
  }
}

class WeatherInfoTilePredictability extends StatelessWidget {
  const WeatherInfoTilePredictability({
    Key? key,
    required this.predictabilityInPercentage,
  }) : super(key: key);

  final int predictabilityInPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.online_prediction),
            const SizedBox(width: Insets.small),
            Flexible(
              child: Text(context.l10n.predictablity),
            ),
          ],
        ),
        const SizedBox(height: Insets.large),
        Center(
          child: Text(
            context.l10n.percentage(predictabilityInPercentage),
            key: const ValueKey('weatherInfoTilePredictability_predictabilityInPercentage_text'),
            style: const TextStyle(fontSize: FontSizes.xxLarge),
          ),
        )
      ],
    );
  }
}
