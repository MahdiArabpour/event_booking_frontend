import 'package:meta/meta.dart';

class ServerException implements Exception {
  final String message;

  ServerException({@required this.message});
}

class SignUpUserException implements Exception {
  final List<String> messages;

  SignUpUserException([this.messages]);
}

class LoginUserException implements Exception {
  final List<String> messages;

  LoginUserException([this.messages]);
}
