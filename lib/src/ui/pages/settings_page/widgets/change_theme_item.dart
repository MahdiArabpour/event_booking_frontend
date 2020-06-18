import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../global/theme/app_themes.dart';
import '../../../global/theme/bloc/bloc.dart';
import '../../../global/providers/theme_provider.dart';

class ChangeThemeItem extends StatefulWidget{
  @override
  _ChangeThemeItemState createState() => _ChangeThemeItemState();
}

class _ChangeThemeItemState extends State<ChangeThemeItem> {
  ThemeBloc bloc;
  ThemeProvider provider;

  _onThemeDropDownMenuItemSelected(String theme) {
    switch (theme) {
      case ThemeNames.INDIGO:
        provider.changeThemeName(ThemeNames.INDIGO);
        bloc.add(ChangeTheme(theme: AppTheme.indigo));
        break;
      case ThemeNames.PURPLE:
        provider.changeThemeName(ThemeNames.PURPLE);
        bloc.add(ChangeTheme(theme: AppTheme.purple));
        break;
      case ThemeNames.RED:
        provider.changeThemeName(ThemeNames.RED);
        bloc.add(ChangeTheme(theme: AppTheme.red));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.bloc<ThemeBloc>();
    provider = Provider.of<ThemeProvider>(context);
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
          value: provider.themeName,
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