import 'package:meta/meta.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:event_booking/src/repositories/event_booking_repository.dart';

class Login {
  final EventBookingRepository repository;

  Login({@required this.repository});

  Future<AuthData> call(String email, String password) async {
      try{
        return await repository.login(email, password);
      }on LoginUserException catch (errors){
        final messages = errors.messages;
        final thereIsAMessage = messages != null && messages.length >= 1;
        if(thereIsAMessage &&  messages[0] == ServerErrorMessages.USER_DOES_NOT_EXIST) throw UserDoesNotExistException();
        throw UnknownServerException();
      }
  }
}