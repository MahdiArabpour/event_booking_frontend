import 'package:meta/meta.dart';

import '../data/datasources/graphql.dart';
import '../data/models/user.dart';

class SignUp {
  final GraphQl graphQl;

  SignUp({@required this.graphQl});

  Future<User> call(String email, String password) async {
    throw UnimplementedError();
  }
}
