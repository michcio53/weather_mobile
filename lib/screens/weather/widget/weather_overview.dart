import 'package:domain/model/consolidated_weather.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile/app/app_assets.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/utils/format_util.dart';
import 'package:weather_mobile/utils/units_util.dart';

class WeatherOverview extends StatelessWidget {
  const WeatherOverview({
    Key? key,
    required this.consolidatedWeather,
    required this.unitsEnum,
  }) : super(key: key);

  final List<ConsolidatedWeather> consolidatedWeather;
  final UnitsEnum unitsEnum;

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
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: Insets.small),
                Flexible(
                  child: Text(
                    context.l10n.forecastForDays(consolidatedWeather.length),
                    style: context.textTheme.headline5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Insets.xSmall),
            ...consolidatedWeather
                .map(
                  (element) => WeatherOverviewSingleTile(
                    singleConsolidatedWeather: element,
                    unitsEnum: unitsEnum,
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}

class WeatherOverviewSingleTile extends StatelessWidget {
  const WeatherOverviewSingleTile({
    Key? key,
    required this.singleConsolidatedWeather,
    required this.unitsEnum,
  }) : super(key: key);

  final ConsolidatedWeather singleConsolidatedWeather;
  final UnitsEnum unitsEnum;

  @override
  Widget build(BuildContext context) {
    final applicableDate = singleConsolidatedWeather.applicableDate?.toDayAndMonth();
    final asset = singleConsolidatedWeather.weatherStateEnum?.toAsset();
    final highTemp = singleConsolidatedWeather.calculatedMaxTemp(unitsEnum);
    final lowTemp = singleConsolidatedWeather.calculatedMinTemp(unitsEnum);
    final temp = singleConsolidatedWeather.calculatedTemp(unitsEnum);

    return Column(
      children: [
        const SizedBox(height: Insets.xSmall),
        Row(
          children: [
            if (applicableDate != null)
              Expanded(
                child: Text(
                  applicableDate,
                  style: context.textTheme.bodyLarge,
                ),
              ),
            if (asset != null)
              Expanded(
                child: context.svgImage(asset),
              ),
            if (highTemp != null)
              Expanded(
                child: Text(
                  context.l10n.highAbbreviationPrefix(highTemp.toString()),
                  key: const ValueKey('WeatherOverviewSingleTile_highTemp_text'),
                  style: context.textTheme.bodyLarge,
                ),
              ),
            if (lowTemp != null)
              Expanded(
                child: Text(
                  context.l10n.lowAbbreviationPrefix(lowTemp.toString()),
                  key: const ValueKey('WeatherOverviewSingleTile_lowTemp_text'),
                  style: context.textTheme.bodyLarge,
                ),
              ),
            if (temp != null)
              Expanded(
                child: Text(
                  context.l10n.avgAbbreviationPrefix(temp.toString()),
                  key: const ValueKey('WeatherOverviewSingleTile_temp_text'),
                  style: context.textTheme.bodyLarge,
                ),
              ),
          ],
        ),
        const SizedBox(height: Insets.xSmall),
      ],
    );
  }
}
