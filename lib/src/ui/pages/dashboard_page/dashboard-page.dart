import 'package:event_booking/src/ui/global/widgets/my_scaffold.dart';
import 'package:event_booking/src/ui/pages/settings_page/settings_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  static const routeName = "/dashboard-page";

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _onOverFlowMenuItemSelected(Choice item) {
    switch (item.index) {
      case 0:
        _onSettingsButtonPressed();
        break;
      case 1:
        _onLogOutButtonPressed();
        break;
    }
  }

  void _onSettingsButtonPressed() =>
      Navigator.of(context).pushNamed(SettingsPage.routeName);

  void _onLogOutButtonPressed() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Logout"),
            content: Text(
              "Are you sure you're going to log out of your account?",
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              RaisedButton(
                onPressed: _onConfirmLogout,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Ok'),
              ),
              SizedBox(width: 0.5),
            ],
          ));

  void _onConfirmLogout() {}

  void _onAddButtonPressed() => print('addEvent');

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBarTitle: Text('Event Booking'),
      appBarActions: <Widget>[
        PopupMenuButton<Choice>(
          onSelected: _onOverFlowMenuItemSelected,
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
        ),
      ],
      body: Center(
        child: Container(child: Text('Hello World')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddButtonPressed,
        child: Icon(Icons.add),
        tooltip: "Add new Event",
      ),
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
