import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/widgets/my_scaffold.dart';
import './bloc/auth_toggle_bloc/bloc.dart';
import './widgets/auth_form.dart';
import './widgets/auth_page_title.dart';

class AuthPage extends StatelessWidget {
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 22.0,
              ),
              AuthPageTitle(),
              AuthForm(
                onSignUp: () {},
                onLogin: () {},
              ),
            ],
          ),
        ),
      );
}
