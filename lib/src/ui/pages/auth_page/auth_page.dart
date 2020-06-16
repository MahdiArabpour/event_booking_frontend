import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/ui/pages/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/widgets/my_scaffold.dart';
import './bloc/auth_toggle_bloc/bloc.dart';
import './widgets/auth_form.dart';
import './widgets/auth_page_title.dart';
import './bloc/submit_bloc/bloc.dart';

class AuthPage extends StatelessWidget {
  final submitBloc = locator<SubmitBloc>();

  void _onSettingButtonTapped(BuildContext context) =>
      Navigator.of(context).pushNamed(SettingsPage.routeName);

  @override
  Widget build(BuildContext context) => MyScaffold(
        appBarTitle: BlocBuilder(
          bloc: context.bloc<ToggleBloc>(),
          builder: (_, state) {
            String title;
            if (state is ToggleLoginState)
              title = 'Login';
            else if (state is ToggleSignUpState) title = 'SignUp';
            return Text(title);
          },
        ),
        appBarActions: [
          IconButton(
            onPressed: () => _onSettingButtonTapped(context),
            tooltip: "Settings",
            icon: Icon(Icons.settings),
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 22.0,
              ),
              AuthPageTitle(),
              AuthForm(
                onSignUp: _onSignUp,
                onLogin: _onLogin,
              ),
            ],
          ),
        ),
      );

  void _onSignUp(String email, String password) {
    submitBloc.add(SignUpEvent(email, password));
  }

  void _onLogin(String email, String password) {
    submitBloc.add(LoginEvent(email, password));
  }
}
