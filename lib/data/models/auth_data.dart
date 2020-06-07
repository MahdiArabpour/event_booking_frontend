import 'package:meta/meta.dart';

class AuthData {
  final String userId;
  final String token;
  final int tokenExpiration;

  AuthData({
    @required this.userId,
    @required this.token,
    @required this.tokenExpiration,
  });
}
