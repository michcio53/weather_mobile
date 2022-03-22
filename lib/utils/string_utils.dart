import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';

extension UnitsEnumExtension on UnitsEnum {
  String toDegreeString(AppLocalizations appLocalizations) {
    switch (this) {
      case UnitsEnum.imperial:
        return appLocalizations.fahrenheitDegreeSufix;
      case UnitsEnum.metric:
        return appLocalizations.celciusDegreeSufix;
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
