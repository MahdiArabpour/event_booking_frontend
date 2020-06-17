import 'package:flutter/material.dart';

import '../../../../usecases/logout.dart';
import '../../../../../service_locator.dart';

class LogoutAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          onPressed: () => _onConfirmLogout(context),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('Ok'),
        ),
        SizedBox(width: 0.5),
      ],
    );
  }

  void _onConfirmLogout(BuildContext context) async {
    final logout = locator<Logout>();
    Navigator.of(context).pop();
    await logout(context);
  }
}
