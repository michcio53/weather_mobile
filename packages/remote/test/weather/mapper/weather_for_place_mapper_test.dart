import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/weather_for_place.dart';
import 'package:remote/weather/mapper/consolidated_weather_mapper.dart';
import 'package:remote/weather/mapper/weather_for_place_mapper.dart';
import 'package:remote/weather/model/response/consolidated_weather_model.dart';
import 'package:remote/weather/model/response/weather_for_place_model.dart';
import 'package:test/test.dart';

void main() {
  test('Maps correct values', () {
    const mapper = WeatherForPlaceMapper(
      consolidatedWeatherMapper: ConsolidatedWeatherMapper(),
    );

    const input = WeatherForPlaceModel(
      title: 'title',
      locationType: 'locationType',
      woeid: 123,
      lattLong: 'lattLong',
      timezone: 'timezone',
      consolidatedWeather: [
        ConsolidatedWeatherModel(
          id: 123,
          weatherStateName: 'weatherStateName',
          weatherStateAbbr: 'weatherStateAbbr',
          windDirectionCompass: 'windDirectionCompass',
          created: 'created',
          applicableDate: '2022-03-22T15:46:17.995757-04:00',
          minTemp: 1.2,
          maxTemp: 1.2,
          theTemp: 1.2,
          windSpeed: 1.2,
          windDirection: 1.2,
          airPressure: 1.2,
          humidity: 1,
          visibility: 1.2,
          predictability: 1,
        ),
      ],
      sunRise: '2022-03-22T15:46:17.995757-04:00',
      sunSet: '2022-03-22T15:46:17.995757-04:00',
      time: '2022-03-22T15:46:17.995757-04:00',
    );

    final output = WeatherForPlace(
      title: 'title',
      locationType: 'locationType',
      woeid: 123,
      lattLong: 'lattLong',
      timezone: 'timezone',
      consolidatedWeather: [
        ConsolidatedWeather(
          id: 123,
          weatherStateName: 'weatherStateName',
          weatherStateAbbr: 'weatherStateAbbr',
          windDirectionCompass: 'windDirectionCompass',
          created: 'created',
          applicableDate: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
          minTemp: 1.2,
          maxTemp: 1.2,
          theTemp: 1.2,
          windSpeed: 1.2,
          windDirection: 1.2,
          airPressure: 1.2,
          humidity: 1,
          visibility: 1.2,
          predictability: 1,
        ),
      ],
      sunRise: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
      sunSet: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
      time: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
    );

    expect(mapper.map(input), output);
  });
}
