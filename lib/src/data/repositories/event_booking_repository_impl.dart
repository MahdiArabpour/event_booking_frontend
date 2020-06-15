
import 'package:meta/meta.dart';

import '../datasources/graphql.dart';
import '../models/auth_data.dart';
import '../models/user.dart';
import '../../repositories/event_booking_repository.dart';
import '../../../core/errors/exceptions.dart';
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

      final createdAuthDataJson = resultJson['data']['login'];

      return AuthData.fromJson(createdAuthDataJson);
    } on ServerException catch (error) {
      throw LoginUserException(error.messages);
    }
  }

  @override
  Future<User> signup(String email, String password) async {
    try {
      final signUpQuery = graphql_mutation.signUp(email, password);

      final resultJson = await graphQl.send(signUpQuery);

      final createdUserJson = resultJson['data']['createUser'];

      return User.fromJson(createdUserJson);
    } on ServerException catch (error) {
      throw SignUpUserException(error.messages);
    }
  }
}
