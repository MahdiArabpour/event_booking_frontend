import 'package:meta/meta.dart';

class ServerException implements Exception {
  final String message;

  ServerException({@required this.message});
}

class SignUpUserException implements Exception {}
