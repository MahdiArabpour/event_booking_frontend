import 'package:event_booking/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../bloc/submit_bloc/bloc.dart';
import '../bloc/auth_toggle_bloc/bloc.dart';
import '../../../global/widgets/button.dart';
import '../../../global/widgets/text_input.dart';
import '../../dashboard_page/dashboard-page.dart';
import '../../../../../core/utils/ui/page_size.dart';
import '../../../../../core/utils/ui/validator.dart';
import '../../../../../core/utils/ui/ui_messages.dart';
import '../../../global/providers/token_provider.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String password) onSignUp;
  final Function(String email, String password) onLogin;
  final TokenProvider tokenProvider;

  const AuthForm({
    Key key,
    this.onSignUp,
    this.onLogin,
    this.tokenProvider,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TapGestureRecognizer _loginTextRecognizer;

  List<Widget> _formWidgets;

  Widget _animatedConfirmPassword;

  Animation _slideAnimation;
  Animation _sizeAnimation;

  AnimationController _slideAnimationController;
  AnimationController _sizeAnimationController;

  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _confirmPasswordFocus;

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  Bloc _toggleBloc;

  String _questionText;
  String _suggestionText;

  bool _isLogin = true;
  bool _didRebuild = false;

  double _confirmPasswordAnimationDirection;

  Validator _validator;

  @override
  void initState() {
    super.initState();

    _confirmPasswordAnimationDirection =
        ConfirmPasswordAnimationDirection.startToEnd;

    _questionText = "Don't have an account?";
    _suggestionText = "Sign Up";

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _slideAnimationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(_slideAnimationListener);

    _sizeAnimationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(_sizeAnimationListener);
    _sizeAnimation = Tween(begin: 0.0, end: 50.0).animate(CurvedAnimation(
      parent: _sizeAnimationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _loginTextRecognizer = TapGestureRecognizer()
      ..onTap = _onSuggestionTextTapped;

    _validator = locator<Validator>();
  }

  void _slideAnimationListener() {
    if (_slideAnimationController.isDismissed) _sizeAnimationController.reverse();
  }

  void _sizeAnimationListener() {
    if (_sizeAnimationController.isCompleted)
      _slideAnimationController.forward();
    else if (_sizeAnimationController.isDismissed) {
      setState(() {
        _confirmPasswordController.text = "";
        _formWidgets.remove(_animatedConfirmPassword);
      });
    }
  }

  Widget _buildAnimatedConfirmPassword(deviceWidth) => AnimatedBuilder(
        animation: _slideAnimationController,
        builder: (_, __) {
          return AnimatedBuilder(
            animation: _sizeAnimationController,
            builder: (_, __) {
              return Transform(
                transform: Matrix4.translationValues(
                    _slideAnimation.value * deviceWidth, 0.0, 0.0),
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
          height: _sizeAnimation.value,
          controller: _confirmPasswordController,
          isPassword: true,
          hintText: 'Confirm Password',
          focusNode: _confirmPasswordFocus,
          textInputAction: TextInputAction.done,
          validator: (_) {
            final confirmPasswordText = _confirmPasswordController.text =
                _confirmPasswordController.text.trim();
            return _validator.validateConfirmPasswordEquality(
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
            return _validator.validateEmail(emailText);
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
            bloc: _toggleBloc,
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
                  return _validator.validatePassword(passwordText);
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
            bloc: _toggleBloc,
            listener: (_, state) {
              _slideAnimation =
                  Tween(begin: _confirmPasswordAnimationDirection, end: 0.0)
                      .animate(
                CurvedAnimation(
                  parent: _slideAnimationController,
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
              );
              if (state is ToggleLoginState) {
                _questionText = "Don't have an account?";
                _suggestionText = "Sign Up";
                _isLogin = true;
              } else if (state is ToggleSignUpState) {
                _questionText = "Have an account?";
                _suggestionText = "Login";
                _isLogin = false;
              }
            },
            builder: (_, state) {
              return _buildSuggestion(_questionText, _suggestionText);
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
    _formWidgets.insert(4, _animatedConfirmPassword);
    _toggleBloc.add(ToggleSignUpEvent());
    _sizeAnimationController.forward();
  }

  void _onConfirmPasswordDismissed(direction) {
    if (direction == DismissDirection.startToEnd)
      _confirmPasswordAnimationDirection =
          ConfirmPasswordAnimationDirection.startToEnd;
    if (direction == DismissDirection.endToStart)
      _confirmPasswordAnimationDirection =
          ConfirmPasswordAnimationDirection.endToStart;
    _removeConfirmPassword(isDismissed: true);
  }

  void _removeConfirmPassword({bool isDismissed = false}) {
    _toggleBloc.add(ToggleLoginEvent());
    if (isDismissed) {
      _formWidgets.remove(_animatedConfirmPassword);
      _slideAnimationController.reverse();
    } else
      _slideAnimationController.reverse();
  }

  _buildSubmitButton(BuildContext context) =>
      BlocConsumer<SubmitBloc, SubmitState>(
        bloc: context.bloc<SubmitBloc>(),
        listener: (context, state) {
          final snackBar = MySnackBar(
            context: context,
            color: Colors.red,
          );
          final toast = locator<Toast>();
          if (state is UserNotExisting)
            snackBar.show('User Not Found, Please sign up first.');
          else if (state is UserAlreadyExists)
            snackBar.show('User Already Exists, Please login.');
          else if (state is IncorrectPassword)
            snackBar.show('Password is incorrect.');
          else if (state is SignedUp)
            toast.show('Signed up, please waite...', length: ToastLength.SHORT);
          else if (state is LoggedIn) {
            widget.tokenProvider.setToken(state.authData.token);
            toast.show("Welcome");
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
    _toggleBloc = BlocProvider.of<ToggleBloc>(context);
    if (!_didRebuild) {
      _animatedConfirmPassword =
          _buildAnimatedConfirmPassword(PageSize(context).deviceWidth);
      _formWidgets = _buildFormWidgets(context);
      _didRebuild = true;
    }
    return BlocBuilder(
        // build method return value
        bloc: _toggleBloc,
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
    _slideAnimationController.dispose();
    _sizeAnimationController.dispose();
    _toggleBloc.close();
  }
}

abstract class ConfirmPasswordAnimationDirection {
  static const double startToEnd = 2.05;
  static const double endToStart = -2.05;
}
