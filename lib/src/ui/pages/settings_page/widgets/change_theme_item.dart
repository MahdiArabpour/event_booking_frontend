import 'package:event_booking/src/ui/global/theme/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/theme/app_themes.dart';

class ChangeThemeItem extends StatefulWidget {
  @override
  _ChangeThemeItemState createState() => _ChangeThemeItemState();
}

class _ChangeThemeItemState extends State<ChangeThemeItem> {
  ThemeChoice choice;
  ThemeBloc bloc;

  @override
  void initState() {
    super.initState();
    choice = themes[0];
  }

  _onThemeDropDownMenuItemSelected(ThemeChoice theme) {
    switch (theme.appTheme) {
      case AppTheme.indigo:
        setState(() => choice = themes[0]);
        bloc.add(ChangeTheme(theme: AppTheme.indigo));
        break;
      case AppTheme.purple:
        setState(() => choice = themes[1]);
        bloc.add(ChangeTheme(theme: AppTheme.purple));
        break;
      case AppTheme.red:
        setState(() => choice = themes[2]);
        bloc.add(ChangeTheme(theme: AppTheme.red));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.bloc<ThemeBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Theme'),
        DropdownButton<ThemeChoice>(
          value: choice,
          onChanged: _onThemeDropDownMenuItemSelected,
          items: themes
              .map((theme) => DropdownMenuItem<ThemeChoice>(
                    value: theme,
                    child: Text(theme.text),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

const themes = const <ThemeChoice>[
  const ThemeChoice(text: "Indigo", appTheme: AppTheme.indigo),
  const ThemeChoice(text: "purple", appTheme: AppTheme.purple),
  const ThemeChoice(text: "red", appTheme: AppTheme.red),
];

class ThemeChoice {
  final AppTheme appTheme;
  final String text;

  const ThemeChoice({
    @required this.appTheme,
    @required this.text,
  });
}
