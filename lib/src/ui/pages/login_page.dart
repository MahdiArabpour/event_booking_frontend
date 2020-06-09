import 'package:event_booking/src/data/models/user.dart';
import 'package:event_booking/src/data/usecases/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../../../service_locator.dart';

import 'dashboard-page.dart';

class LoginPage extends StatelessWidget {

  Future<String> _authUser(LoginData data) {
  }

  Future<String> _signUpUser(LoginData data) async {
    final signUp = locator<SignUp>();
    final result = await signUp(data.name, data.password);
    if(result is User) return null;
    return "Couldn't sign up";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Event\nBooking',
      onLogin: _authUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ));
      },
    );
  }
}