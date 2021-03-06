class ServerException implements Exception {
  final List<String> messages;

  ServerException({this.messages});
}

class SignUpUserException implements Exception {
  ///Contains a list of error messages gotten from the graphql server
  final List<String> messages;

  SignUpUserException([this.messages]);
}

class LoginUserException implements Exception {
  ///Contains a list of error messages gotten from the graphql server
  final List<String> messages;

  LoginUserException([this.messages]);
}

class PostEventException implements Exception {
  ///Contains a list of error messages gotten from the graphql server
  final List<String> messages;

  PostEventException([this.messages]);
}

class BookEventException implements Exception {
  ///Contains a list of error messages gotten from the graphql server
  final List<String> messages;

  BookEventException([this.messages]);
}

class EmptyQueryException {
  final String message;

  EmptyQueryException([this.message]);
}

class UserAlreadyExistException implements Exception {}

class UserDoesNotExistException implements Exception {}

class IncorrectPasswordException implements Exception {}

class AuthenticationException implements Exception {}

class NoInternetConnectionException implements Exception{}

class UnknownServerException implements Exception {}

abstract class ServerErrorMessages {
  static const USER_ALREADY_EXISTS = "User already Exists";
  static const USER_DOES_NOT_EXIST = "User does not exist";
  static const INCORRECT_PASSWORD = "Password is incorrect!";
  static const AUTH_FAILED = "Authentication failed";
  static const USER_NOT_FOUND = "User not found";
}
