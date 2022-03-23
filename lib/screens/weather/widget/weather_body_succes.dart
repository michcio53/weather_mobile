import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_mobile/app/dimen.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                style: const TextStyle(
                  fontSize: FontSizes.xxLarge,
                ),
                textAlign: TextAlign.center,
              ),
              MainTemperature(
                consolidatedWeather: consolidatedWeather,
                unitsEnum: unitsEnum,
              ),
              const SizedBox(height: Insets.small),
              Text(
                consolidatedWeather.weatherStateName,
                key: const ValueKey('WeatherBodySuccess_weatherForPlaceWeatherStateName_text'),
                style: const TextStyle(
                  fontSize: FontSizes.xLarge,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Insets.small),
              HighLowTemperatureRow(
                consolidatedWeather: consolidatedWeather,
                unitsEnum: unitsEnum,
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
              WeatherInfoTile.wind(
                windSpeedKm: consolidatedWeather.windSpeedKm,
                windSpeedMph: consolidatedWeather.windSpeed,
                windDirectionCompass: consolidatedWeather.windDirectionCompass,
                unitsEnum: unitsEnum,
              ),
              WeatherInfoTile.humidity(
                humidityInPercentage: consolidatedWeather.humidity,
              ),
              WeatherInfoTile.visibility(
                visiblityKm: consolidatedWeather.visibilityKm,
                visiblityMph: consolidatedWeather.visibility,
                unitsEnum: unitsEnum,
              ),
              WeatherInfoTile.airPressure(
                airPressureInMbar: consolidatedWeather.airPressure,
              ),
              WeatherInfoTile.predictability(
                predictabilityInPercentage: consolidatedWeather.predictability,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainTemperature extends StatelessWidget {
  const MainTemperature({
    Key? key,
    required this.consolidatedWeather,
    required this.unitsEnum,
  }) : super(key: key);

  final ConsolidatedWeather consolidatedWeather;
  final UnitsEnum unitsEnum;

  double get _theTemp {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return consolidatedWeather.theTempFahrenheit.roundToOneDigitAfterComa();
      case UnitsEnum.metric:
        return consolidatedWeather.theTemp.roundToOneDigitAfterComa();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_theTemp ${unitsEnum.toDegreeString(context.l10n)}',
      style: const TextStyle(
        fontSize: 50,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class HighLowTemperatureRow extends StatelessWidget {
  const HighLowTemperatureRow({
    Key? key,
    required this.consolidatedWeather,
    required this.unitsEnum,
  }) : super(key: key);

  final ConsolidatedWeather consolidatedWeather;
  final UnitsEnum unitsEnum;

  double get _displayedMaxTemp {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return consolidatedWeather.maxTempFahrenheit.roundToOneDigitAfterComa();
      case UnitsEnum.metric:
        return consolidatedWeather.maxTemp.roundToOneDigitAfterComa();
    }
  }

  double get _displayedMinTemp {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return consolidatedWeather.minTempFahrenheit.roundToOneDigitAfterComa();

      case UnitsEnum.metric:
        return consolidatedWeather.minTemp.roundToOneDigitAfterComa();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Text(
          context.l10n.highAbbreviation(
            _displayedMaxTemp,
            unitsEnum.toDegreeString(context.l10n),
          ),
          key: const ValueKey('HighLowTemperatureRow_displayedMaxTemp_text'),
        ),),
        const SizedBox(width: Insets.small),
        Flexible(
          child: Text(
            context.l10n.lowAbbreviation(
              _displayedMinTemp,
              unitsEnum.toDegreeString(context.l10n),
            ),
            key: const ValueKey('HighLowTemperatureRow_displayedMinTemp_text'),
          ),
        ),
      ],
    );
  }
}
