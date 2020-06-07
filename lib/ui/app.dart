import 'package:flutter/material.dart';

import 'pages/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orange,
        cursorColor: Colors.orange,
        textTheme: TextTheme(
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
