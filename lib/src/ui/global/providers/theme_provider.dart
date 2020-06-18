import 'package:flutter/material.dart';
import 'package:event_booking/service_locator.dart';

import '../theme/app_themes.dart';
import '../../../usecases/cache_theme.dart';

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