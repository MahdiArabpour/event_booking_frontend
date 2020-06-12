import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:meta/meta.dart';

import '../datasources/graphql.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/graphql/queries.dart' as graphql_query;

class Login {
  final GraphQl graphQl;

  Login({@required this.graphQl});

  /// Sends user information to the graphql server to check if user is
  /// signed up previously
  Future<AuthData> call(String email, String password) async {
    try {
      final signUpQuery = graphql_query.login(email, password);

      final resultJson = await graphQl.send(signUpQuery);

      if (resultJson['errors'] != null) {
        List<Map<String, dynamic>> errors = resultJson['errors'];
        List<String> errorMessages =
            errors.map((e) => e['message'] as String).toList();
        throw LoginUserException(errorMessages);
      }

      final createdAuthDataJson = resultJson['data']['login'];

      return AuthData.fromJson(createdAuthDataJson);
    } on ServerException {
      throw LoginUserException();
    }
  }
}
