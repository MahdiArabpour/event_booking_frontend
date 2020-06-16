
import 'package:event_booking/src/ui/global/widgets/my_scaffold.dart';
import 'package:event_booking/src/ui/pages/settings_page/widgets/change_theme_item.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings-page';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        appBarTitle: Text('Settings'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0,),
          child: Column(
            children: [
              ChangeThemeItem(),
            ],
          ),
        ));
  }

}
