import 'package:meta/meta.dart';

import '../data/models/user.dart';
import '../repositories/event_booking_repository.dart';
import '../../core/errors/exceptions.dart';

class SignUp {
  final EventBookingRepository repository;

  SignUp({@required this.repository});

  Future<User> call(String email, String password) async {
    try {
      return await repository.signup(email, password);
    } on SignUpUserException catch (errors) {
      final messages = errors.messages;
      final thereIsAMessage = messages != null && messages.length >= 1;
      if (thereIsAMessage &&
          messages[0] == ServerErrorMessages.USER_ALREADY_EXISTS)
        throw UserAlreadyExistException();
      throw UnknownServerException();
    }
  }
}
