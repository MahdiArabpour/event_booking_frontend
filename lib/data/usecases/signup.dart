import '../models/user.dart';

abstract class SignUp {
  Future<User> call(String email, String password);
}

class SignUpImpl implements SignUp{
  @override
  Future<User> call(String email, String password) {
    throw UnimplementedError();
  }
}