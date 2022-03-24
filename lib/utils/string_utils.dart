import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

extension UnitsEnumExtension on UnitsEnum {
  String toDegreeString(AppLocalizations appLocalizations, double temp) {
    switch (this) {
      case UnitsEnum.imperial:
        return appLocalizations.fahrenheitDegreeSufix(temp);
      case UnitsEnum.metric:
        return appLocalizations.celciusDegreeSufix(temp);
    }
  }

  String toStringValue(AppLocalizations appLocalizations) {
    switch (this) {
      case UnitsEnum.imperial:
        return appLocalizations.imperial;
      case UnitsEnum.metric:
        return appLocalizations.metric;
    }
  }
}
