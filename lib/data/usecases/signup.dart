import 'package:event_booking/core/errors/exceptions.dart';
import 'package:meta/meta.dart';

import '../datasources/graphql.dart';
import '../models/user.dart';

class SignUp {
  final GraphQl graphQl;

  SignUp({@required this.graphQl});

  /// Sends user information to the graphql server to create new user account
  /// and if signup was successful returns created [User] Object!
  Future<User> call(String email, String password) async {
    try{
      final signUpQuery =
          'mutation{createUser(userInput: {email: "$email", password: "$password"}) {_id,email, }}';

      final resultJson = await graphQl.send(signUpQuery);

      final createdUserJson = resultJson['data']['createUser'];

      return User.fromJson(createdUserJson);
    }
    on ServerException {
      throw SignUpUserException();
    }
  }
}