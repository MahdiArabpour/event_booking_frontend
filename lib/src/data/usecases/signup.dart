import 'package:meta/meta.dart';

import '../datasources/graphql.dart';
import '../models/user.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/graphql/queries.dart' as graphql_query;

class SignUp {
  final GraphQl graphQl;

  SignUp({@required this.graphQl});

  /// Sends user information to the graphql server to create new user account
  /// and if signup was successful returns created [User] Object!
  Future<User> call(String email, String password) async {
    try {
      final signUpQuery = graphql_query.signUp(email, password);

      final resultJson = await graphQl.send(signUpQuery);

      if (resultJson['errors'] != null) {
        List<Map<String, dynamic>> errors = resultJson['errors'];
        List<String> errorMessages =
            errors.map((e) => e['message'] as String).toList();
        throw SignUpUserException(errorMessages);
      }

      final createdUserJson = resultJson['data']['createUser'];

      return User.fromJson(createdUserJson);
    } on ServerException {
      throw SignUpUserException();
    }
  }
}
