import 'package:domain/model/weather_for_place.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/utils/utils.dart';
import 'package:remote/weather/mapper/consolidated_weather_mapper.dart';
import 'package:remote/weather/model/response/weather_for_place_model.dart';

class WeatherForPlaceMapper
    implements Mapper<WeatherForPlaceModel, WeatherForPlace> {
  const WeatherForPlaceMapper({
    required ConsolidatedWeatherMapper consolidatedWeatherMapper,
  }) : _consolidatedWeatherMapper = consolidatedWeatherMapper;

  final ConsolidatedWeatherMapper _consolidatedWeatherMapper;

  @override
  WeatherForPlace map(WeatherForPlaceModel element) {
    return WeatherForPlace(
      title: element.title,
      locationType: element.locationType,
      woeid: element.woeid,
      lattLong: element.lattLong,
      timezone: element.timezone,
      consolidatedWeather: element.consolidatedWeather
          .map(_consolidatedWeatherMapper.map)
          .toList(),
      sunRise: element.sunRise.removeTimeZoneFromString(),
      sunSet: element.sunSet.removeTimeZoneFromString(),
      time: DateTime.parse(element.time),
    );
  }
}
