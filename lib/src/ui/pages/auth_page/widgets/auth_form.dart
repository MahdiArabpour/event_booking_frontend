import 'package:event_booking/core/utils/ui/ui_messages.dart';
import 'package:event_booking/service_locator.dart';
import 'package:event_booking/src/ui/pages/auth_page/bloc/submit_bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/dashboard-page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/ui/page_size.dart';
import '../../../../../core/utils/ui/validator.dart';
import '../../../global/widgets/button.dart';
import '../../../global/widgets/text_input.dart';
import '../bloc/auth_toggle_bloc/bloc.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String password) onSignUp;
  final Function(String email, String password) onLogin;

  const AuthForm({
    Key key,
    this.onSignUp,
    this.onLogin,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TapGestureRecognizer _loginTextRecognizer;

  List<Widget> _formWidgets;

  Widget animatedConfirmPassword;

  Animation slideAnimation;
  Animation sizeAnimation;

  AnimationController slideAnimationController;
  AnimationController sizeAnimationController;

  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _confirmPasswordFocus;

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  Bloc toggleBloc;

  String questionText;
  String suggestionText;

  bool _isLogin = true;
  bool _didRebuild = false;

  double confirmPasswordAnimationDirection;

  Validator validator;

  @override
  void initState() {
    super.initState();

    confirmPasswordAnimationDirection =
        ConfirmPasswordAnimationDirection.startToEnd;

    questionText = "Don't have an account?";
    suggestionText = "Sign Up";

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    slideAnimationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(_slideAnimationListener);

    sizeAnimationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(_sizeAnimationListener);
    sizeAnimation = Tween(begin: 0.0, end: 50.0).animate(CurvedAnimation(
      parent: sizeAnimationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _loginTextRecognizer = TapGestureRecognizer()
      ..onTap = _onSuggestionTextTapped;

    validator = locator<Validator>();
  }

  void _slideAnimationListener() {
    if (slideAnimationController.isDismissed) sizeAnimationController.reverse();
  }

  void _sizeAnimationListener() {
    if (sizeAnimationController.isCompleted)
      slideAnimationController.forward();
    else if (sizeAnimationController.isDismissed) {
      setState(() {
        _confirmPasswordController.text = "";
        _formWidgets.remove(animatedConfirmPassword);
      });
    }
  }

  Widget _buildAnimatedConfirmPassword(deviceWidth) => AnimatedBuilder(
        animation: slideAnimationController,
        builder: (_, __) {
          return AnimatedBuilder(
            animation: sizeAnimationController,
            builder: (_, __) {
              return Transform(
                transform: Matrix4.translationValues(
                    slideAnimation.value * deviceWidth, 0.0, 0.0),
                child: _buildConfirmPasswordDismissible(),
              );
            },
          );
        },
      );

  Widget _buildSuggestion(String questionText, String suggestionText) =>
      RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: '$questionText '),
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

  Widget _buildConfirmPasswordDismissible() => Dismissible(
        key: Key('confirmPassword'),
        onDismissed: _onConfirmPasswordDismissed,
        child: TextInput(
          height: sizeAnimation.value,
          controller: _confirmPasswordController,
          isPassword: true,
          hintText: 'Confirm Password',
          focusNode: _confirmPasswordFocus,
          textInputAction: TextInputAction.done,
          validator: (_) {
            final confirmPasswordText = _confirmPasswordController.text =
                _confirmPasswordController.text.trim();
            validator.validateConfirmPasswordEquality(
                _passwordController.text, confirmPasswordText);
          },
          onSubmitted: (_) {},
        ),
      );

  List<Widget> _buildFormWidgets(BuildContext context) => [
        TextInput(
          height: 50,
          hintText: 'Email',
          controller: _emailController,
          autoFocus: true,
          validator: (_) {
            final emailText =
                _emailController.text = _emailController.text.trim();
            validator.validateEmail(emailText);
          },
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            _emailFocus.unfocus();
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer(
            // build method return value
            bloc: toggleBloc,
            listener: (_, __) async {
              if (_passwordFocus.hasFocus) {
                _passwordFocus.unfocus();
                await Future.delayed(Duration(milliseconds: 100));
                FocusScope.of(context).requestFocus(_passwordFocus);
              } else if (_confirmPasswordFocus.hasFocus) {
                _confirmPasswordFocus.unfocus();
                await Future.delayed(Duration(milliseconds: 100));
                FocusScope.of(context).requestFocus(_passwordFocus);
              }
            },
            builder: (_, state) {
              return TextInput(
                height: 50,
                hintText: 'Password',
                controller: _passwordController,
                isPassword: true,
                focusNode: _passwordFocus,
                validator: (_) {
                  final passwordText = _passwordController.text =
                      _passwordController.text.trim();
                  validator.validatePassword(passwordText);
                },
                textInputAction:
                    _isLogin ? TextInputAction.done : TextInputAction.next,
                onSubmitted: (_) {
                  _passwordFocus.unfocus();
                  if (!_isLogin)
                    FocusScope.of(context).requestFocus(_confirmPasswordFocus);
                },
              );
            }),
        const SizedBox(
          height: 10,
        ),
//      animatedConfirmPassword,
        const SizedBox(
          height: 10,
        ),
        _buildSubmitButton(context),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer(
            // build method return value
            bloc: toggleBloc,
            listener: (_, state) {
              slideAnimation =
                  Tween(begin: confirmPasswordAnimationDirection, end: 0.0)
                      .animate(CurvedAnimation(
                parent: slideAnimationController,
                curve: Curves.fastLinearToSlowEaseIn,
              ));
              if (state is ToggleLoginState) {
                questionText = "Don't have an account?";
                suggestionText = "Sign Up";
                _isLogin = true;
              } else if (state is ToggleSignUpState) {
                questionText = "Have an account?";
                suggestionText = "Login";
                _isLogin = false;
              }
            },
            builder: (_, state) {
              return _buildSuggestion(questionText, suggestionText);
            }),
      ];

  void _onSubmitButtonTapped() {
    if (formKey.currentState.validate()) {
      if (_isLogin)
        widget.onLogin(_emailController.text, _passwordController.text);
      else
        widget.onSignUp(_emailController.text, _passwordController.text);
    }
  }

  void _onSuggestionTextTapped() {
    if (_isLogin)
      _insertConfirmPassword();
    else
      _removeConfirmPassword();
  }

  void _insertConfirmPassword() {
    _formWidgets.insert(4, animatedConfirmPassword);
    toggleBloc.add(ToggleSignUpEvent());
    sizeAnimationController.forward();
  }

  void _onConfirmPasswordDismissed(direction) {
    if (direction == DismissDirection.startToEnd)
      confirmPasswordAnimationDirection =
          ConfirmPasswordAnimationDirection.startToEnd;
    if (direction == DismissDirection.endToStart)
      confirmPasswordAnimationDirection =
          ConfirmPasswordAnimationDirection.endToStart;
    _removeConfirmPassword(isDismissed: true);
  }

  void _removeConfirmPassword({bool isDismissed = false}) {
    toggleBloc.add(ToggleLoginEvent());
    if (isDismissed) {
      _formWidgets.remove(animatedConfirmPassword);
      slideAnimationController.reverse();
    } else
      slideAnimationController.reverse();
  }

  _buildSubmitButton(BuildContext context) =>
      BlocConsumer<SubmitBloc, SubmitState>(
        bloc: context.bloc<SubmitBloc>(),
        listener: (context, state) {
          final snackBar = MySnackBar(
            context: context,
            color: Colors.red,
          );
          final toast = Toast();
          if (state is UserNotExisting)
            snackBar.show('User Not Found, Please sign up first.');
          else if (state is UserAlreadyExists)
            snackBar.show('User Already Exists, Please login.');
          else if (state is IncorrectPassword)
            snackBar.show('Password is incorrect.');
          else if (state is SignedUp)
            toast.show('Signed up, please waite.', length: ToastLength.SHORT);
          else if (state is LoggedIn) {
            toast.show("Welcome. You're all set.");
            Navigator.of(context).pushReplacementNamed(DashboardPage.routeName);
          } else if (state is NoInternet)
            snackBar.show('Please check your internet connection');
          else if (state is UnknownError)
            snackBar.show('An unknown error occured');
        },
        builder: (context, state) {
          bool isLoading = state is Loading || state is SignedUp;
          return Button(
            onTap: isLoading ? null : _onSubmitButtonTapped,
            child: isLoading
                ? Center(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    'Submit',
                    style: Theme.of(context).textTheme.button,
                  ),
            height: 45.0,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    toggleBloc = BlocProvider.of<ToggleBloc>(context);
    if (!_didRebuild) {
      animatedConfirmPassword =
          _buildAnimatedConfirmPassword(PageSize(context).deviceWidth);
      _formWidgets = _buildFormWidgets(context);
      _didRebuild = true;
    }
    return BlocBuilder(
        // build method return value
        bloc: toggleBloc,
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _formWidgets,
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    slideAnimationController.dispose();
    sizeAnimationController.dispose();
    toggleBloc.close();
  }
}

abstract class ConfirmPasswordAnimationDirection {
  static const double startToEnd = 2.0;
  static const double endToStart = -2.0;
}
