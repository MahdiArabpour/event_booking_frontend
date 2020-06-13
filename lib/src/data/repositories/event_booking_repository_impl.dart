import 'package:event_booking/core/errors/exceptions.dart';
import 'package:meta/meta.dart';

import '../datasources/graphql.dart';
import '../models/auth_data.dart';
import '../models/user.dart';
import '../../repositories/event_booking_repository.dart';
import '../../../core/utils/graphql/queries.dart' as graphql_query;
import '../../../core/utils/graphql/mutations.dart' as graphql_mutation;

class EventBookingRepositoryImpl implements EventBookingRepository {
  final GraphQl graphQl;

  EventBookingRepositoryImpl({@required this.graphQl});

  @override
  Future<AuthData> login(String email, String password) async {
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
    } on ServerException catch (error) {
      throw LoginUserException([error.message]);
    }
  }

  @override
  Future<User> signup(String email, String password) async {
    try {
      final signUpQuery = graphql_mutation.signUp(email, password);

      final resultJson = await graphQl.send(signUpQuery);

      if (resultJson['errors'] != null) {
        List<Map<String, dynamic>> errors = resultJson['errors'];
        List<String> errorMessages =
            errors.map((e) => e['message'] as String).toList();
        throw SignUpUserException(errorMessages);
      }

      final createdUserJson = resultJson['data']['createUser'];

      return User.fromJson(createdUserJson);
    } on ServerException catch (error) {
      throw SignUpUserException([error.message]);
    }
  }
}
