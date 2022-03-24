import 'package:domain/model/consolidated_weather.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/utils/format_util.dart';

extension ConsolidatedWeatherExtension on ConsolidatedWeather {
  double? calculatedTemp(UnitsEnum unitsEnum) {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return theTempFahrenheit?.oneDigitAfterComa();
      case UnitsEnum.metric:
        return theTemp?.oneDigitAfterComa();
    }
  }

  double? calculatedMaxTemp(UnitsEnum unitsEnum) {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return maxTempFahrenheit?.oneDigitAfterComa();
      case UnitsEnum.metric:
        return maxTemp?.oneDigitAfterComa();
    }
  }

  double? calculatedMinTemp(UnitsEnum unitsEnum) {
    switch (unitsEnum) {
      case UnitsEnum.imperial:
        return minTempFahrenheit?.oneDigitAfterComa();
      case UnitsEnum.metric:
        return minTemp?.oneDigitAfterComa();
    }
  }
}
