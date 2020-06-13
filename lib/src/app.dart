import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/ui/pages/auth_page/bloc/submit_bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/dashboard-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './ui/pages/auth_page/auth_page.dart';
import './ui/pages/auth_page/bloc/auth_toggle_bloc/bloc.dart';

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
      routes: {
        '/': (_) => MultiBlocProvider(
              providers: [
                BlocProvider<ToggleBloc>(
                  create: (_) => locator<ToggleBloc>(),
                ),
                BlocProvider<SubmitBloc>(
                  create: (_) => locator<SubmitBloc>(),
                ),
              ],
              child: AuthPage(),
            ),
        DashboardPage.routeName: (_) => DashboardPage(),
      },
    );
  }
}
