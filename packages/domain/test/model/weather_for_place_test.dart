import 'package:domain/model/weather_for_place.dart';
import 'package:test/test.dart';

void main() {
  test('check if copyWith and date time parse works', () {
    final weatherForPlace = WeatherForPlace(
      title: 'title',
      locationType: 'locationType',
      woeid: 123,
      lattLong: 'lattLong',
      timezone: 'timezone',
      consolidatedWeather: const [],
      sunRise: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
      sunSet: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
      time: DateTime.parse('2022-03-22T15:46:17.995757-04:00'),
    );
    final weatherWithChangedTitle = weatherForPlace.copyWith(title: 'newTitle');
    final weatherWithChangedWoeid = weatherForPlace.copyWith(woeid: 321);

    expect(weatherWithChangedTitle.title, 'newTitle');
    expect(weatherWithChangedWoeid.woeid, 321);
    expect(weatherForPlace.sunRise.year, 2022);
    expect(weatherForPlace.sunRise.month, 03);
    expect(weatherForPlace.sunRise.day, 22);
  });
}
