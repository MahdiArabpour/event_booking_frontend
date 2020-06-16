import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/ui/global/theme/bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/auth_page/bloc/submit_bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/settings_page/settings_page.dart';
import 'file:///D:/Programing%20Projects/flutter_projects/event_booking/lib/src/ui/pages/dashboard_page/dashboard-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/pages/auth_page/bloc/auth_toggle_bloc/bloc.dart';

class App extends StatelessWidget {
  final Widget launcherPage;

  App(this.launcherPage);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToggleBloc>(
          create: (_) => locator<ToggleBloc>(),
        ),
        BlocProvider<SubmitBloc>(
          create: (_) => locator<SubmitBloc>(),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => locator<ThemeBloc>(),
        )
      ],
      child: BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context, state) => MaterialApp(
          title: 'Event Booking',
          debugShowCheckedModeBanner: false,
          theme: state.theme.light,
          darkTheme: state.theme.dark,
          home: launcherPage,
          routes: {
            DashboardPage.routeName: (_) => DashboardPage(),
            SettingsPage.routeName: (_) => SettingsPage(),
          },
        ),
      ),
    );
  }
}
