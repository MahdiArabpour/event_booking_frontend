import 'package:flutter/material.dart';

enum AppTheme {
  indigo,
  purple,
  red,
}

final appThemeData = {
  AppTheme.indigo: AppThemeData(
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
      accentColor: Colors.pink,
      cursorColor: Colors.pink,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
  ),
  AppTheme.purple: AppThemeData(
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
      accentColor: Colors.deepOrange,
      cursorColor: Colors.deepOrange,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
      textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.white),
        button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
      ),
    ),
  ),
  AppTheme.red: AppThemeData(
    light: ThemeData(
      primarySwatch: Colors.red,
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
      accentColor: Colors.green,
      cursorColor: Colors.green,
      brightness: Brightness.dark,
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
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

  AppThemeData({
    @required this.light,
    @required this.dark,
  });
}
