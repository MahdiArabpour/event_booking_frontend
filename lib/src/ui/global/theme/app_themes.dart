import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/usecases/cache_theme.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  indigo,
  purple,
  red,
}

final appThemeData = {
  AppTheme.indigo: AppThemeData(
    themeName: ThemeNames.INDIGO,
    light: ThemeData(
      primarySwatch: Colors.indigo,
      accentColor: Colors.pink,
      cursorColor: Colors.pink,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.blueGrey),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
    dark: ThemeData(
      primaryColor: Colors.indigo[900],
      accentColor: Colors.pink[900],
      cursorColor: Colors.pink,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[800]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
  ),
  AppTheme.purple: AppThemeData(
    themeName: ThemeNames.PURPLE,
    light: ThemeData(
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.deepOrange,
      cursorColor: Colors.deepOrange,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.blueGrey),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
    dark: ThemeData(
      primaryColor: Colors.deepPurple[900],
      accentColor: Colors.deepOrange[900],
      cursorColor: Colors.deepOrange,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[800]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
  ),
  AppTheme.red: AppThemeData(
    themeName: ThemeNames.RED,
    light: ThemeData(
      primaryColor: Colors.red[600],
      accentColor: Colors.green,
      cursorColor: Colors.green,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.blueGrey),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
    dark: ThemeData(
      primaryColor: Colors.red[900],
      accentColor: Colors.green[900],
      cursorColor: Colors.green,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[800]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
  ),
};

class AppThemeData {
  final ThemeData light;
  final ThemeData dark;
  final String themeName;

  AppThemeData({
    @required this.light,
    @required this.dark,
    @required this.themeName,
  });
}

abstract class ThemeNames{
  static const INDIGO = "Indigo";
  static const PURPLE = "Purple";
  static const RED = "Red";
}


Future<AppThemeData> loadDefaultTheme() async {

  final cacheTheme = locator<CacheTheme>();

  AppThemeData appTheme;
  final theme = await cacheTheme.get();

  switch (theme) {
    case ThemeNames.PURPLE:
      appTheme = AppThemeData(
        themeName: ThemeNames.PURPLE,
        light: appThemeData[AppTheme.purple].light,
        dark: appThemeData[AppTheme.purple].dark,
      );
      break;
    case ThemeNames.RED:
      appTheme = AppThemeData(
        themeName: ThemeNames.RED,
        light: appThemeData[AppTheme.red].light,
        dark: appThemeData[AppTheme.red].dark,
      );
      break;
    default:
      appTheme = AppThemeData(
        themeName: ThemeNames.INDIGO,
        light: appThemeData[AppTheme.indigo].light,
        dark: appThemeData[AppTheme.indigo].dark,
      );
      break;
  }

  return appTheme;
}