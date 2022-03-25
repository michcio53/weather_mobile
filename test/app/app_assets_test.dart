import 'package:domain/model/consolidated_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_mobile/app/app_assets.dart';

void main() {
  test('check if Assets coreectly map weatherState', () {
    final consolidatedWeatherClear = consolidatedWeather;
    expect(consolidatedWeatherClear.weatherStateEnum?.toAsset(), AppAssets.c);
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'h')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.h,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'hc')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.hc,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'hr')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.hr,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'lc')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.lc,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'lr')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.lr,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 's')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.s,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'sl')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.sl,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 'sn')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.sn,
    );
    expect(
      consolidatedWeatherClear
          .copyWith(weatherStateAbbr: 't')
          .weatherStateEnum
          ?.toAsset(),
      AppAssets.t,
    );
  });
}

final consolidatedWeather = ConsolidatedWeather(
  id: 123,
  weatherStateName: 'weatherStateName',
  weatherStateAbbr: 'c',
  windDirectionCompass: 'windDirectionCompass',
  created: 'created',
  applicableDate: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
  minTemp: 10,
  maxTemp: 15,
  theTemp: 10,
  windSpeed: 10,
  windDirection: 1.2,
  airPressure: 1.2,
  humidity: 1,
  visibility: 10,
  predictability: 1,
);
