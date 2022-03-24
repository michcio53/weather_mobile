import 'package:domain/model/consolidated_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class AppAssets {
  static const String _assetsPath = 'assets';
  static const String _svgPath = '$_assetsPath/svg';
  static const String _weatherPath = '$_svgPath/weather';

  static const String c = '$_weatherPath/c.svg';
  static const String h = '$_weatherPath/h.svg';
  static const String hc = '$_weatherPath/hc.svg';
  static const String hr = '$_weatherPath/hr.svg';
  static const String lc = '$_weatherPath/lc.svg';
  static const String lr = '$_weatherPath/lr.svg';
  static const String s = '$_weatherPath/s.svg';
  static const String sl = '$_weatherPath/sl.svg';
  static const String sn = '$_weatherPath/sn.svg';
  static const String t = '$_weatherPath/t.svg';
}

extension Assets on BuildContext {
  SvgPicture svgImage(String name, {Color? color, Size? size}) => SvgPicture.asset(
        name,
        color: color,
        width: size?.width,
        height: size?.height,
      );
}

extension WeatherStateEnumExtenstion on WeatherStateEnum {
  String toAsset() {
    switch (this) {
      case WeatherStateEnum.snow:
        return AppAssets.s;
      case WeatherStateEnum.sleet:
        return AppAssets.sl;
      case WeatherStateEnum.hail:
        return AppAssets.h;
      case WeatherStateEnum.thunderstorm:
        return AppAssets.t;
      case WeatherStateEnum.heavyRain:
        return AppAssets.hr;
      case WeatherStateEnum.ligtRain:
        return AppAssets.lr;
      case WeatherStateEnum.showers:
       return AppAssets.s;
      case WeatherStateEnum.heavyCloud:
        return AppAssets.hc;
      case WeatherStateEnum.lightCloud:
        return AppAssets.lc;
      case WeatherStateEnum.clear:
        return AppAssets.c;
    }
  }
}
