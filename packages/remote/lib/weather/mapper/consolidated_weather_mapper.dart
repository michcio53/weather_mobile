import 'package:domain/model/consolidated_weather.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/weather/model/response/consolidated_weather_model.dart';

class ConsolidatedWeatherMapper implements Mapper<ConsolidatedWeatherModel, ConsolidatedWeather> {
  const ConsolidatedWeatherMapper();

  @override
  ConsolidatedWeather map(ConsolidatedWeatherModel element) {
    return ConsolidatedWeather(
      id: element.id,
      weatherStateName: element.weatherStateName,
      weatherStateAbbr: element.weatherStateAbbr,
      windDirectionCompass: element.windDirectionCompass,
      created: element.created,
      applicableDate: element.applicableDate,
      minTemp: element.minTemp,
      maxTemp: element.maxTemp,
      theTemp: element.theTemp,
      windSpeed: element.windSpeed,
      windDirection: element.windDirection,
      airPressure: element.airPressure,
      humidity: element.humidity,
      visibility: element.visibility,
      predictability: element.predictability,
    );
  }
}
