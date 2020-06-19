import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../global/theme/bloc/bloc.dart';
import '../../../global/theme/app_themes.dart';
import '../../../global/providers/theme_provider.dart';

class ChangeThemeItem extends StatefulWidget{
  @override
  _ChangeThemeItemState createState() => _ChangeThemeItemState();
}

class _ChangeThemeItemState extends State<ChangeThemeItem> {
  ThemeBloc _bloc;
  ThemeProvider _provider;

  _onThemeDropDownMenuItemSelected(String theme) {
    switch (theme) {
      case ThemeNames.INDIGO:
        _provider.changeThemeName(ThemeNames.INDIGO);
        _bloc.add(ChangeTheme(theme: AppTheme.indigo));
        break;
      case ThemeNames.PURPLE:
        _provider.changeThemeName(ThemeNames.PURPLE);
        _bloc.add(ChangeTheme(theme: AppTheme.purple));
        break;
      case ThemeNames.RED:
        _provider.changeThemeName(ThemeNames.RED);
        _bloc.add(ChangeTheme(theme: AppTheme.red));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _bloc = context.bloc<ThemeBloc>();
    _provider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Theme',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.subtitle1.color,
          ),
        ),
        DropdownButton<String>(
          value: _provider.themeName,
          onChanged: _onThemeDropDownMenuItemSelected,
          underline: null,
          items: themes
              .map((theme) => DropdownMenuItem<String>(
                    value: theme,
                    child: Text(theme),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

const themes = const <String>[
  ThemeNames.INDIGO,
  ThemeNames.PURPLE,
  ThemeNames.RED,
];