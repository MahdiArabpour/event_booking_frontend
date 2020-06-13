import 'package:event_booking/core/errors/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';
import 'package:event_booking/src/usecases/login.dart';
import 'package:event_booking/src/usecases/signup.dart';

class SubmitBloc extends Bloc<SubmitEvent, SubmitState> {
  final SignUp signUp;
  final Login login;
  final FlutterSecureStorage secureStorage;

  SubmitBloc({
    @required this.signUp,
    @required this.login,
    @required this.secureStorage,
  });

  @override
  SubmitState get initialState => InitialSubmitState();

  @override
  Stream<SubmitState> mapEventToState(SubmitEvent event) async* {
    yield Loading();
    if (event is SignUpEvent) {
      yield* _trySignUp(event.email, event.password);
    } else if (event is LoginEvent) {
      yield* _tryLogin(event.email, event.password);
    }
  }

  Stream<SubmitState> _trySignUp(String email, String password) async* {
    try{
      await signUp(email, password);
      yield SignedUp();
      yield* _tryLogin(email, password);
    }on UserAlreadyExistException{
      yield UserAlreadyExists();
    }on UnknownServerException{
      yield UnknownError();
    }
  }

  Stream<SubmitState> _tryLogin(String email, String password) async* {
    try{
      final authData = await login(email, password);
      await secureStorage.write(key: "access_token", value: authData.token);
      yield LoggedIn();
    }on UserDoesNotExistException{
      yield UserNotExisting();
    } on IncorrectPasswordException{
      yield IncorrectPassword();
    } on UnknownServerException{
      yield UnknownError();
    }
  }
}
