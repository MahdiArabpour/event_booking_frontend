import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../app_themes.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  ThemeEvent();
}

class ChangeTheme extends ThemeEvent {
  final AppTheme theme;

  ChangeTheme({
    @required this.theme,
  });

  @override
  List<Object> get props => [theme];
}
