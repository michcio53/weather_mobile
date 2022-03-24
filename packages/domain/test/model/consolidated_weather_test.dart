import 'package:domain/model/consolidated_weather.dart';
import 'package:test/test.dart';

void main() {
  test('check calculating getter variables and copyWith', () {
    expect(consolidatedWeather.weatherStateEnum, WeatherStateEnum.clear);
    expect(consolidatedWeather.minTempFahrenheit, 50);
    expect(consolidatedWeather.maxTempFahrenheit, 59);
    expect(consolidatedWeather.theTempFahrenheit, 50);
    expect(consolidatedWeather.applicableDate?.year, 2022);
    expect(consolidatedWeather.windSpeedKm, 16.09344);
    expect(consolidatedWeather.visibilityKm, 16.09344);

    final copiedWeather = consolidatedWeather.copyWith(id: 321);

    expect(copiedWeather.id, 321);
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
