import 'package:remote/weather/model/response/weather_for_place_model.dart';
import 'package:test/test.dart';

void main() {
  test('check if model correctly maps the fields', () async {
    final weatherForPlace = WeatherForPlaceModel.fromJson(weatherForPlaceMap);
    expect(weatherForPlace.title, "New York");
    expect(weatherForPlace.woeid, 2459115);
    expect(weatherForPlace.consolidatedWeather.length, 1);
  });

  test('throw an error if not json not complete', () async {
    expect(() => WeatherForPlaceModel.fromJson(weatherForPlaceUncomplete), throwsA(isA<TypeError>()));
  });

  test('check if model creates json', () {
    final weatherForPlace = WeatherForPlaceModel.fromJson(weatherForPlaceMap);
    final jsonModel = weatherForPlace.toJson();
    expect(jsonModel, weatherForPlaceMap);
  });
}

final weatherForPlaceMap = <String, dynamic>{
  "title": "New York",
  "location_type": "City",
  "woeid": 2459115,
  "latt_long": "40.71455,-74.007118",
  "timezone": "US/Eastern",
  "time": "2022-03-23T02:32:24.690752-04:00",
  "sun_rise": "2022-03-23T06:54:24.114949-04:00",
  "sun_set": "2022-03-23T19:11:23.285215-04:00",
  "consolidated_weather": [
    {
      "id": 5779246732541952,
      "weather_state_name": "Clear",
      "weather_state_abbr": "c",
      "wind_direction_compass": "WNW",
      "created": "2022-03-25T05:04:59.040443Z",
      "applicable_date": "2022-03-25",
      "min_temp": 2.2350000000000003,
      "max_temp": 15.07,
      "the_temp": 13.09,
      "wind_speed": 5.33530053887961,
      "wind_direction": 293.16645878328194,
      "air_pressure": 1027.0,
      "humidity": 46,
      "visibility": 15.116407679153742,
      "predictability": 68
    },
  ]
};

final weatherForPlaceUncomplete = <String, dynamic>{
  "title": "New York",
  "location_type": "City",
  "woeid": 2459115,
};
