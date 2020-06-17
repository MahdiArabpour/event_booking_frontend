import 'package:meta/meta.dart';

import '../data/models/auth_data.dart';
import '../../core/errors/exceptions.dart';
import '../repositories/remote_data_source_repository.dart';

class Login {
  final RemoteDataSourceRepository repository;

  Login({@required this.repository});

  Future<AuthData> call(String email, String password) async {
    try {
      return await repository.login(email, password);
    } on LoginUserException catch (errors) {
      final messages = errors.messages;

      final thereIsAMessage = messages != null && messages.length >= 1;

      if (thereIsAMessage &&
          messages.first == ServerErrorMessages.USER_DOES_NOT_EXIST)
        throw UserDoesNotExistException();

      if (thereIsAMessage &&
          messages.first == ServerErrorMessages.INCORRECT_PASSWORD)
        throw IncorrectPasswordException();

      throw UnknownServerException();
    }
  }
}
