import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc.dart';
import '../app_themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeState(theme: appThemeData[AppTheme.indigo]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeTheme)
      yield ThemeState(theme: appThemeData[event.theme]);
  }
}
