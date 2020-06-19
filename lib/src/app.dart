import 'package:event_booking/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './ui/global/theme/bloc/bloc.dart';
import './ui/global/providers/theme_provider.dart';
import './ui/global/providers/token_provider.dart';
import './ui/pages/settings_page/settings_page.dart';
import './ui/pages/dashboard_page/dashboard-page.dart';
import './ui/pages/auth_page/bloc/submit_bloc/bloc.dart';
import './ui/pages/auth_page/bloc/auth_toggle_bloc/bloc.dart';
import './ui/pages/dashboard_page/bloc/post_event_bloc/bloc.dart';
import 'ui/pages/dashboard_page/bloc/get_events_bloc/bloc.dart';

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
        ),
        BlocProvider<PostEventBloc>(
          create: (_) => locator<PostEventBloc>(),
        ),
        BlocProvider<GetEventsBloc>(
          create: (_) => locator<GetEventsBloc>(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TokenProvider(),
          ),
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
      ),
    );
  }
}
