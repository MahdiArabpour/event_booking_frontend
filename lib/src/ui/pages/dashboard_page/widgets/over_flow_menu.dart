import 'package:flutter/material.dart';

import './logout_alert.dart';
import '../../settings_page/settings_page.dart';

class OverFlowMenu extends StatelessWidget {
  void _onOverFlowMenuItemSelected(Choice item, BuildContext context) {
    switch (item.index) {
      case 0:
        _onSettingsButtonPressed(context);
        break;
      case 1:
        _onLogOutButtonPressed(context);
        break;
    }
  }

  void _onSettingsButtonPressed(BuildContext context) =>
      Navigator.of(context).pushNamed(SettingsPage.routeName);

  void _onLogOutButtonPressed(BuildContext context) =>
      showDialog(context: context, builder: (context) => LogoutAlert());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choice>(
      onSelected: (item) => _onOverFlowMenuItemSelected(item, context),
      itemBuilder: (BuildContext context) {
        return choices
            .map((Choice choice) => PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        choice.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Icon(
                        choice.icon,
                        color: Theme.of(context).textTheme.subtitle1.color,
                      ),
                    ],
                  ),
                ))
            .toList();
      },
    );
  }
}

class Choice {
  final int index;
  final String title;
  final IconData icon;

  const Choice({
    this.index,
    this.title,
    this.icon,
  });
}

const List<Choice> choices = const <Choice>[
  const Choice(
    index: 0,
    title: "Settings",
    icon: Icons.settings,
  ),
  const Choice(
    index: 1,
    title: "Logout",
    icon: Icons.exit_to_app,
  ),
];
