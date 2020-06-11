import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/widgets/button.dart';
import '../../../global/widgets/text_input.dart';
import '../bloc/signup_login_toggle_bloc/bloc.dart';

class SignUpLoginForm extends StatefulWidget {
  final Function onSignUp;
  final Function onLogin;

  const SignUpLoginForm({
    Key key,
    this.onSignUp,
    this.onLogin,
  }) : super(key: key);

  @override
  _SignUpLoginFormState createState() => _SignUpLoginFormState();
}

class _SignUpLoginFormState extends State<SignUpLoginForm>
    with SingleTickerProviderStateMixin {
  GlobalKey<AnimatedListState> animatedListKey;
  TapGestureRecognizer _loginTextRecognizer;
  List<Widget> loginFormWidgets;
  bool _isSignUp;
  double confirmPasswordAnimationDirection;
  Bloc<ToggleEvent, ToggleState> toggleBloc;

  @override
  void initState() {
    super.initState();

    animatedListKey = GlobalKey<AnimatedListState>();

    _loginTextRecognizer = TapGestureRecognizer()
      ..onTap = () {
        _toggleLoginAndSignUp();
      };

    _isSignUp = false;
    confirmPasswordAnimationDirection =
        ConfirmPasswordAnimationDirection.startToEnd;

    confirmPassword = Dismissible(
      key: Key('confirmPassword'),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd)
          confirmPasswordAnimationDirection =
              ConfirmPasswordAnimationDirection.startToEnd;
        else
          confirmPasswordAnimationDirection =
              ConfirmPasswordAnimationDirection.endToStart;
        _removeConfirmPassword();
        _isSignUp = false;
      },
      confirmDismiss: (_) async => true,
      child: const TextInput(
        hintText: 'Confirm Password',
      ),
    );
  }

  Widget confirmPassword;

  @override
  Widget build(BuildContext context) {
    toggleBloc = context.bloc<ToggleBloc>();

    loginFormWidgets = [
      const TextInput(
        hintText: 'Email',
      ),
      const SizedBox(
        height: 10,
      ),
      const TextInput(
        hintText: 'Password',
      ),
      const SizedBox(
        height: 10,
      ),
//      confirmPassword,
      const SizedBox(
        height: 10,
      ),
      Button(
        onTap: _onSubmitButtonTapped,
        text: 'Submit',
        height: 45.0,
      ),
      const SizedBox(
        height: 10,
      ),
      BlocBuilder(
        bloc: toggleBloc,
        builder: (context, state) {
          String questionText;
          String suggestionText;

          switch (state.runtimeType) {
            case ToggleSignUpState:
              questionText = "Have an account? ";
              suggestionText = "Login";
              break;
            case ToggleLoginState:
              questionText = "Don't have an account? ";
              suggestionText = "Sign Up";
              break;
          }

          return RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: questionText),
                TextSpan(
                  text: suggestionText,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: _loginTextRecognizer,
                ),
              ],
            ),
          );
        },
      ),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(20),
      child: AnimatedList(
        physics: NeverScrollableScrollPhysics(),
        key: animatedListKey,
        initialItemCount: loginFormWidgets.length,
        itemBuilder: _buildAnimatedListItem,
      ),
    );
  }

  void _onSubmitButtonTapped() {
    if (_isSignUp)
      widget.onSignUp();
    else
      widget.onLogin();
  }

  Widget _buildAnimatedListItem(context, index, animation) => SlideTransition(
        position: Tween(
                begin: Offset(confirmPasswordAnimationDirection, 0.0),
                end: Offset.zero)
            .animate(animation),
        child: loginFormWidgets.elementAt(index),
      );

  void _toggleLoginAndSignUp() {
    if (_isSignUp) {
      confirmPasswordAnimationDirection =
          ConfirmPasswordAnimationDirection.startToEnd;
      _removeConfirmPassword();
    } else
      _addConfirmPassword();
    _isSignUp = !_isSignUp;
  }

  void _removeConfirmPassword() {
    toggleBloc.add(ToggleLoginEvent());
    var removed =
        loginFormWidgets.removeAt(loginFormWidgets.indexOf(confirmPassword));
    animatedListKey.currentState.removeItem(
        4,
        (context, animation) => SlideTransition(
              position: Tween(
                      begin: Offset(
                          ConfirmPasswordAnimationDirection.startToEnd, 0.0),
                      end: Offset.zero)
                  .animate(animation),
              child: removed,
            ));
  }

  void _addConfirmPassword() {
    toggleBloc.add(ToggleSignUpEvent());
    loginFormWidgets.insert(4, confirmPassword);
    animatedListKey.currentState.insertItem(4);
  }
}

abstract class ConfirmPasswordAnimationDirection {
  static const double startToEnd = 1.5;
  static const double endToStart = -1.5;
}
