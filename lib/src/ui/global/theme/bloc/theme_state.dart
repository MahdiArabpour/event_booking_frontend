import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../app_themes.dart';
@immutable
class ThemeState extends Equatable {
  final AppThemeData theme;

  ThemeState({
    @required this.theme,
  });

  @override
  List<Object> get props => [theme];
}
