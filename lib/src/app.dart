import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/pages/signup_login_page/signup_login_page.dart';
import './ui/pages/signup_login_page/bloc/signup_login_toggle_bloc/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pink,
        cursorColor: Colors.pink,
        backgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[200]),
        textTheme: TextTheme(
          button: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
        ),
      ),
      home: BlocProvider(
        create: (_) => ToggleBloc(),
        child: SignUpLoginPage(),
      ),
    );
  }
}
