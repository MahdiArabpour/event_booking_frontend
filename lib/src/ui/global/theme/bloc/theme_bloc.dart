import 'package:event_booking/src/usecases/cache_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../app_themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final CacheTheme cacheTheme;
  final ThemeState initialThemeState;

  ThemeBloc({
    @required this.cacheTheme,
    @required this.initialThemeState,
  });

  @override
  ThemeState get initialState => initialThemeState;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeTheme) {
      cacheTheme(appThemeData[event.theme].themeName);
      yield ThemeState(theme: appThemeData[event.theme]);
    }
  }
}
