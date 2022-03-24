// ignore_for_file: overridden_fields
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Palette {
  late Brightness brightness;
  late Color darkGrayColor;
  late Color shadowColor;
  late Color inactiveColor;
  late Color primaryColor;
  late Color primaryDarkColor;
  late Color accentColor;
  late Color iconColor;
  late Color backgroundColor;
  late Color appBarBackgroundColor;
  late Color primaryTextDisplayColor;
  late Color primaryTextBodyColor;
}

class LightPalette extends Palette {
  @override
  final Brightness brightness = Brightness.light;
  @override
  final Color shadowColor = const Color(0x1A3C640D);
  @override
  final Color darkGrayColor = const Color(0xff4D4D4F);
  @override
  final Color inactiveColor = const Color(0xffA1A3A6);
  @override
  final Color primaryColor = const Color(0xff1A3C64);
  @override
  final Color primaryDarkColor = const Color(0xff112C4B);
  @override
  final Color accentColor = const Color(0xff1FA0B0);
  @override
  final Color iconColor = const Color(0xff163567);
  @override
  final Color backgroundColor = const Color(0xffF8F9F9);
  @override
  final Color primaryTextBodyColor = const Color(0xff173047);
  @override
  final Color primaryTextDisplayColor = const Color(0xff173047);
  @override
  final Color appBarBackgroundColor = const Color(0xffF8F9F9);
}

class DarkPalette extends Palette {
  @override
  final Brightness brightness = Brightness.light;
  @override
  final Color darkGrayColor = const Color(0xff4D4D4F);
  @override
  final Color shadowColor = const Color(0x1A3C640D);
  @override
  final Color inactiveColor = const Color(0xffA1A3A6);
  @override
  final Color primaryColor = Colors.white;
  @override
  final Color primaryDarkColor = const Color(0xff112C4B);
  @override
  final Color accentColor = const Color(0xff1FA0B0);
  @override
  final Color iconColor = Colors.white;
  @override
  final Color backgroundColor = const Color(0xff486383);
  @override
  final Color primaryTextBodyColor = Colors.white;
  @override
  final Color primaryTextDisplayColor = Colors.white;
  @override
  final Color appBarBackgroundColor = const Color(0xff486383);
}

class AppTheme {
  static Palette paletteOf(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.light) {
      return LightPalette();
    } else if (brightness == Brightness.dark) {
      return DarkPalette();
    } else {
      return LightPalette();
    }
  }

  ThemeData theme(Palette palette) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _generateMaterialColor(palette.primaryColor),
        primaryColorDark: palette.primaryDarkColor,
        accentColor: palette.accentColor,
        backgroundColor: palette.backgroundColor,
        brightness: palette.brightness,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryTextTheme: _textThemeHandset.apply(
        bodyColor: palette.primaryTextBodyColor,
        displayColor: palette.primaryTextDisplayColor,
      ),
      textTheme: _textThemeHandset.apply(
        bodyColor: palette.primaryTextBodyColor,
        displayColor: palette.primaryTextDisplayColor,
      ),
      iconTheme: IconThemeData(color: palette.iconColor),
      canvasColor: palette.backgroundColor,
      backgroundColor: palette.backgroundColor,
      scaffoldBackgroundColor: palette.backgroundColor,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: palette.brightness,
          statusBarIconBrightness: palette.brightness,
          systemNavigationBarIconBrightness: palette.brightness,
        ),
        toolbarTextStyle: TextStyle(color: palette.primaryColor),
        titleTextStyle: TextStyle(color: palette.primaryColor, fontWeight: FontWeight.bold, fontSize: 16),
        color: palette.appBarBackgroundColor,
        iconTheme: IconThemeData(color: palette.iconColor),
        actionsIconTheme: IconThemeData(color: palette.iconColor),
      ),
    );
    return theme;
  }

  TextTheme get _textThemeHandset => TextTheme(
        headline1: GoogleFonts.lato(
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headline2: GoogleFonts.lato(
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headline3: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
        headline5: GoogleFonts.lato(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        headline6: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        button: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        caption: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        overline: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      );

  MaterialColor _generateMaterialColor(Color color) => MaterialColor(color.value, {
        50: _tintColor(color, 0.9),
        100: _tintColor(color, 0.8),
        200: _tintColor(color, 0.6),
        300: _tintColor(color, 0.4),
        400: _tintColor(color, 0.2),
        500: color,
        600: _shadeColor(color, 0.1),
        700: _shadeColor(color, 0.2),
        800: _shadeColor(color, 0.3),
        900: _shadeColor(color, 0.4),
      });

  int _tintValue(int value, double factor) => max(
        0,
        min((value + ((255 - value) * factor)).round(), 255),
      );

  Color _tintColor(Color color, double factor) => Color.fromRGBO(
        _tintValue(color.red, factor),
        _tintValue(color.green, factor),
        _tintValue(color.blue, factor),
        1,
      );

  int _shadeValue(int value, double factor) => max(
        0,
        min(value - (value * factor).round(), 255),
      );

  Color _shadeColor(Color color, double factor) => Color.fromRGBO(
        _shadeValue(color.red, factor),
        _shadeValue(color.green, factor),
        _shadeValue(color.blue, factor),
        1,
      );
}

extension AppThemes on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppBarTheme get appBarThemes => theme.appBarTheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Palette get palette => AppTheme.paletteOf(this);

  ColorScheme get colors => theme.colorScheme;
}
