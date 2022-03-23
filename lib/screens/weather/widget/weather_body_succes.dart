import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_info_tile.dart';
import 'package:weather_mobile/utils/format_util.dart';
import 'package:weather_mobile/utils/string_utils.dart';

class WeatherBodySuccess extends StatelessWidget {
  const WeatherBodySuccess({
    Key? key,
    required this.weatherForPlace,
    required this.consolidatedWeather,
    required this.unitsEnum,
  }) : super(key: key);

  final WeatherForPlace weatherForPlace;
  final ConsolidatedWeather consolidatedWeather;
  final UnitsEnum unitsEnum;

  double? get _theTemp {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return consolidatedWeather.theTempFahrenheit?.roundToOneDigitAfterComa();
      case UnitsEnum.metric:
        return consolidatedWeather.theTemp?.roundToOneDigitAfterComa();
    }
  }

  double? get _maxTemp {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
      case UnitsEnum.metric:
        return consolidatedWeather.maxTemp?.roundToOneDigitAfterComa();
    }
  }

  double? get _minTemp {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return consolidatedWeather.minTempFahrenheit?.roundToOneDigitAfterComa();

      case UnitsEnum.metric:
        return consolidatedWeather.minTemp?.roundToOneDigitAfterComa();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherStateName = consolidatedWeather.weatherStateName;
    final windSpeedKm = consolidatedWeather.windSpeedKm;
    final windSpeed = consolidatedWeather.windSpeed;
    final windDirectionCompass = consolidatedWeather.windDirectionCompass;
    final visibilityKm = consolidatedWeather.visibilityKm;
    final visibility = consolidatedWeather.visibility;
    final predictability = consolidatedWeather.predictability;
    final airPressure = consolidatedWeather.airPressure;
    final humidity = consolidatedWeather.humidity;

    return RefreshIndicator(
      onRefresh: () async => context.read<WeatherBloc>().add(WeatherStarted()),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: Insets.medium,
                ),
                Text(
                  weatherForPlace.title,
                  key: const ValueKey('WeatherBodySuccess_weatherForPlaceTitle_text'),
                  style: context.textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                if (_theTemp != null)
                  Text(
                    '$_theTemp ${unitsEnum.toDegreeString(context.l10n)}',
                    style: context.textTheme.headline1?.copyWith(fontSize: FontSizes.xxxLarge),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: Insets.small),
                if (weatherStateName != null)
                  Text(
                    weatherStateName,
                    key: const ValueKey('WeatherBodySuccess_weatherForPlaceWeatherStateName_text'),
                    style: context.textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: Insets.small),
                if (_maxTemp != null && _minTemp != null)
                  HighLowTemperatureRow(
                    unitsEnum: unitsEnum,
                    maxTemp: _maxTemp!,
                    minTemp: _minTemp!,
                  ),
                const SizedBox(
                  height: Insets.medium,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            sliver: SliverGrid.count(
              mainAxisSpacing: Insets.medium,
              crossAxisSpacing: Insets.medium,
              crossAxisCount: 2,
              children: [
                WeatherInfoTile.time(
                  sunRise: weatherForPlace.sunRise,
                  sunSet: weatherForPlace.sunSet,
                ),
                if (windSpeedKm != null && windSpeed != null && windDirectionCompass != null)
                  WeatherInfoTile.wind(
                    windSpeedKm: windSpeedKm,
                    windSpeedMph: windSpeed,
                    windDirectionCompass: windDirectionCompass,
                    unitsEnum: unitsEnum,
                  ),
                if (humidity != null)
                  WeatherInfoTile.humidity(
                    humidityInPercentage: humidity,
                  ),
                if (visibility != null && visibilityKm != null)
                  WeatherInfoTile.visibility(
                    visiblityKm: visibilityKm,
                    visiblityMph: visibility,
                    unitsEnum: unitsEnum,
                  ),
                if (airPressure != null)
                  WeatherInfoTile.airPressure(
                    airPressureInMbar: airPressure,
                  ),
                if (predictability != null)
                  WeatherInfoTile.predictability(
                    predictabilityInPercentage: predictability,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HighLowTemperatureRow extends StatelessWidget {
  const HighLowTemperatureRow({
    Key? key,
    required this.maxTemp,
    required this.minTemp,
    required this.unitsEnum,
  }) : super(key: key);

  final double maxTemp;
  final double minTemp;
  final UnitsEnum unitsEnum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            context.l10n.highAbbreviation(
              maxTemp,
              unitsEnum.toDegreeString(context.l10n),
            ),
            key: const ValueKey('HighLowTemperatureRow_displayedMaxTemp_text'),
            style: context.textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: Insets.small),
        Flexible(
          child: Text(
            context.l10n.lowAbbreviation(
              minTemp,
              unitsEnum.toDegreeString(context.l10n),
            ),
            key: const ValueKey('HighLowTemperatureRow_displayedMinTemp_text'),
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
