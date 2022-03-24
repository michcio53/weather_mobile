import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/screens/weather/widget/weather_info_tile.dart';
import 'package:weather_mobile/screens/weather/widget/weather_overview.dart';
import 'package:weather_mobile/utils/string_utils.dart';
import 'package:weather_mobile/utils/units_util.dart';

class WeatherBodySuccess extends StatelessWidget {
  const WeatherBodySuccess({
    Key? key,
    required this.weatherForPlace,
    required this.consolidatedWeather,
    required this.unitsEnum,
  }) : super(key: key);

  final WeatherForPlace weatherForPlace;
  final List<ConsolidatedWeather> consolidatedWeather;
  final UnitsEnum unitsEnum;

  @override
  Widget build(BuildContext context) {
    final todaysConsolidatedWeather = consolidatedWeather.first;
    final weatherStateName = todaysConsolidatedWeather.weatherStateName;
    final windSpeedKm = todaysConsolidatedWeather.windSpeedKm;
    final windSpeed = todaysConsolidatedWeather.windSpeed;
    final windDirectionCompass = todaysConsolidatedWeather.windDirectionCompass;
    final visibilityKm = todaysConsolidatedWeather.visibilityKm;
    final visibility = todaysConsolidatedWeather.visibility;
    final predictability = todaysConsolidatedWeather.predictability;
    final airPressure = todaysConsolidatedWeather.airPressure;
    final humidity = todaysConsolidatedWeather.humidity;
    final highTemp = todaysConsolidatedWeather.calculatedMaxTemp(unitsEnum);
    final lowTemp = todaysConsolidatedWeather.calculatedMinTemp(unitsEnum);
    final temp = todaysConsolidatedWeather.calculatedTemp(unitsEnum);

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
                if (temp != null)
                  Text(
                    unitsEnum.toDegreeString(context.l10n, temp),
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
                if (highTemp != null && lowTemp != null)
                  HighLowTemperatureRow(
                    unitsEnum: unitsEnum,
                    maxTemp: highTemp,
                    minTemp: lowTemp,
                  ),
                const SizedBox(
                  height: Insets.medium,
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
            sliver: SliverToBoxAdapter(
              child: WeatherOverview(
                consolidatedWeather: consolidatedWeather,
                unitsEnum: unitsEnum,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: Insets.medium),
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
            context.l10n.highAbbreviationPrefix(
              unitsEnum.toDegreeString(
                context.l10n,
                maxTemp,
              ),
            ),
            key: const ValueKey('HighLowTemperatureRow_displayedMaxTemp_text'),
            style: context.textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: Insets.small),
        Flexible(
          child: Text(
            context.l10n.lowAbbreviationPrefix(
              unitsEnum.toDegreeString(
                context.l10n,
                minTemp,
              ),
            ),
            key: const ValueKey('HighLowTemperatureRow_displayedMinTemp_text'),
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
