import 'package:remote/weather/model/response/consolidated_weather_model.dart';
import 'package:test/test.dart';

void main() {
  test('check if model correctly maps the fields', () async {
    final consolodatedWeather =
        ConsolidatedWeatherModel.fromJson(consolidatedWeatherModel);
    expect(consolodatedWeather.id, 5881096244822016);
    expect(consolodatedWeather.created, '2022-03-23T03:59:46.543167Z');
    expect(consolodatedWeather.minTemp, 5.67);
    expect(consolodatedWeather.visibility, 7.299558080808081);
    expect(consolodatedWeather.maxTemp, null);
  });

  test('check if model creates json', () {
    final consolidatedWeather =
        ConsolidatedWeatherModel.fromJson(consolidatedWeatherModel);
    final jsonModel = consolidatedWeather.toJson();
    jsonModel['max_temp'] = null;
    expect(jsonModel, consolidatedWeatherModel);
  });
}

final consolidatedWeatherModel = <String, dynamic>{
  "id": 5881096244822016,
  "weather_state_name": "Light Rain",
  "weather_state_abbr": "lr",
  "wind_direction_compass": "NE",
  "created": "2022-03-23T03:59:46.543167Z",
  "applicable_date": "2022-03-23",
  "min_temp": 5.67,
  "max_temp": null,
  "the_temp": 11.335,
  "wind_speed": 7.603085834844509,
  "wind_direction": 45.06847955775026,
  "air_pressure": 1016.5,
  "humidity": 54,
  "visibility": 7.299558080808081,
  "predictability": 75
};
