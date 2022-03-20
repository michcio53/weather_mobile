import 'package:domain/model/consolidated_weather.dart';
import 'package:domain/model/location.dart';
import 'package:remote/weather/mapper/consolidated_weather_mapper.dart';
import 'package:remote/weather/mapper/location_mapper.dart';
import 'package:remote/weather/model/response/consolidated_weather_model.dart';
import 'package:remote/weather/model/response/location_model.dart';
import 'package:test/test.dart';

void main() {
  test('Maps correct values', () {
    const mapper = LocationMapper();

    const input = LocationModel(
      title: 'title',
      locationType: 'locationType',
      lattLong: 'lattLong',
      woeid: 123,
    );

    const output = Location(
      title: 'title',
      locationType: 'locationType',
      lattLong: 'lattLong',
      woeid: 123,
    );

    expect(mapper.map(input), output);
  });
}
