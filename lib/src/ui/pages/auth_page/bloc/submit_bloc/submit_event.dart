import 'package:equatable/equatable.dart';

abstract class SubmitEvent extends Equatable {}

class LoginEvent extends SubmitEvent{
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object> get props =>[email,password];
}

class SignUpEvent extends SubmitEvent{
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);

  @override
  List<Object> get props =>[email,password];
}
