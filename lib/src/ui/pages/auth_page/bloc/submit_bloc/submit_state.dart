import 'package:equatable/equatable.dart';
import 'package:event_booking/src/data/models/auth_data.dart';

abstract class SubmitState extends Equatable {}

class InitialSubmitState extends SubmitState{
  @override
  List<Object> get props => const [];
}

class Loading extends SubmitState{
  @override
  List<Object> get props => const [];
}

class SignedUp extends SubmitState{
  @override
  List<Object> get props => const [];
}

class LoggedIn extends SubmitState{
  final AuthData authData;

  LoggedIn(this.authData);

  @override
  List<Object> get props => const [];
}

class UserNotExisting extends SubmitState{
  @override
  List<Object> get props => const [];
}

class UserAlreadyExists extends SubmitState{
  @override
  List<Object> get props => const [];
}

class IncorrectPassword extends SubmitState{
  @override
  List<Object> get props => const [];
}

class NoInternet extends SubmitState{
  @override
  List<Object> get props => const [];
}

class UnknownError extends SubmitState{
  @override
  List<Object> get props => const [];
}
