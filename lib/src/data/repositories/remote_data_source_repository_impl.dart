import 'package:event_booking/src/data/models/event.dart';
import 'package:meta/meta.dart';

import '../datasources/graphql.dart';
import '../models/auth_data.dart';
import '../models/user.dart';
import '../../repositories/remote_data_source_repository.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/graphql/queries.dart' as graphql_query;
import '../../../core/utils/graphql/mutations.dart' as graphql_mutation;

class RemoteDataSourceRepositoryImpl implements RemoteDataSourceRepository {
  final GraphQl graphQl;

  RemoteDataSourceRepositoryImpl({@required this.graphQl});

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

  @override
  Future<List<Event>> getEvents() async {
    final eventsQuery = graphql_query.getEvents(
      title: true,
      description: true,
      date: true,
      price: true,
      creator: true,
    );

    final resultJson = await graphQl.send(eventsQuery);

    final eventsJson = resultJson['data']['events'];

    final listOfEvents = eventsJson
        .map((eventJson) => Event.fromJson(eventJson))
        .cast<Event>()
        .toList();

    return listOfEvents;
  }

  @override
  Future<Event> postEvent(Event event) async {
    final createEventQuery = graphql_mutation.createEvent(
      title: event.title,
      description: event.description,
      price: event.price,
      dateISOString: event.date.toIso8601String(),
    );

    final resultJson = await graphQl.send(createEventQuery);

    final eventJson = resultJson['data']['createEvent'];

    final createdEvent = Event(
      (b) => b
        ..id = eventJson['_id']
        ..title = event.title
        ..description = event.description
        ..date = event.date
        ..price = event.price
        ..creator = event.creator.toBuilder(),
    );

    return createdEvent;
  }
}
