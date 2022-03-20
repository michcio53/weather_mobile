import 'package:domain/model/consolidated_weather.dart';
import 'package:remote/weather/mapper/consolidated_weather_mapper.dart';
import 'package:remote/weather/model/response/consolidated_weather_model.dart';
import 'package:test/test.dart';

void main() {
  test('Maps correct values', () {
    const mapper = ConsolidatedWeatherMapper();

    const input = ConsolidatedWeatherModel(
      id: 123,
      weatherStateName: 'weatherStateName',
      weatherStateAbbr: 'weatherStateAbbr',
      windDirectionCompass: 'windDirectionCompass',
      created: 'created',
      applicableDate: 'applicableDate',
      minTemp: 1.2,
      maxTemp: 1.2,
      theTemp: 1.2,
      windSpeed: 1.2,
      windDirection: 1.2,
      airPressure: 1.2,
      humidity: 1,
      visibility: 1.2,
      predictability: 1,
    );

    const output = ConsolidatedWeather(
      id: 123,
      weatherStateName: 'weatherStateName',
      weatherStateAbbr: 'weatherStateAbbr',
      windDirectionCompass: 'windDirectionCompass',
      created: 'created',
      applicableDate: 'applicableDate',
      minTemp: 1.2,
      maxTemp: 1.2,
      theTemp: 1.2,
      windSpeed: 1.2,
      windDirection: 1.2,
      airPressure: 1.2,
      humidity: 1,
      visibility: 1.2,
      predictability: 1,
    );

    expect(mapper.map(input), output);
  });
}
