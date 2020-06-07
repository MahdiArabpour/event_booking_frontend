import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'dashboard-page.dart';

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Event\nBooking',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ));
      },
    );
  }
}