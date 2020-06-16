import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/ui/global/theme/app_themes.dart';
import 'package:event_booking/src/usecases/cache_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  String _themeName;

  ThemeProvider(){
    _loadThemeName();
  }

  String get themeName => _themeName;

  void changeThemeName(String themeName){
    this._themeName = themeName;
    notifyListeners();
  }

  _loadThemeName() async {
    final cachedTheme = locator<CacheTheme>();
    final themeName = await cachedTheme.get() ?? ThemeNames.INDIGO;
    changeThemeName(themeName);
  }
}