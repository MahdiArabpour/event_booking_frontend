import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/widgets/my_scaffold.dart';
import './bloc/signup_login_toggle_bloc/bloc.dart';
import './widgets/signup_login_form.dart';
import './widgets/signup_login_title.dart';

class SignUpLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: BlocBuilder(
          bloc: context.bloc<ToggleBloc>(),
          builder: (_, state) {
            String title;
            if (state is ToggleLoginState)
              title = 'Login';
            else if (state is ToggleSignUpState) title = 'SignUp';
            return Text(title);
          },
        ),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 22.0,
            ),
            SignUpTitle(),
            SignUpLoginForm(
              onSignUp: () {},
              onLogin: () {},
            ),
          ],
        ),
      ),
    );
  }
}
