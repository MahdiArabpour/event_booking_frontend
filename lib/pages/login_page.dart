import 'package:event_booking/pages/dashboard-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
      return null;
  }

  Future<String> _recoverPassword(String name) {
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
      onRecoverPassword: null,
    );
  }
}