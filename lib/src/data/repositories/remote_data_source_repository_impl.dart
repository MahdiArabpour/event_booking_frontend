import 'package:meta/meta.dart';

import '../models/user.dart';
import '../models/event.dart';
import '../models/auth_data.dart';
import '../datasources/graphql.dart';
import '../../../core/errors/exceptions.dart';
import '../../repositories/remote_data_source_repository.dart';
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
  Future<Event> postEvent(Event event, {@required String token}) async {
    try{
      final dateISOString =  event.date.toIso8601String();

      final createEventQuery = graphql_mutation.createEvent(
        title: event.title,
        description: event.description,
        price: event.price,
        dateISOString: dateISOString,
      );

      final resultJson = await graphQl.send(createEventQuery, token: token);

      final eventJson = resultJson['data']['createEvent'];

      final Map<String, dynamic> createdEventJson = {
        ...eventJson,
        'title': event.title,
        'description': event.description,
        'price': event.price,
        'date': dateISOString,
      };

      return Event.fromJson(createdEventJson);
    } on ServerException catch (error){
      throw PostEventException(error.messages);
    }
  }

  @override
  Future<List<Event>> getEvents() async {
    final eventsQuery = graphql_query.getEvents(
      id: true,
      title: true,
      description: true,
      date: true,
      price: true,
      creator: true,
    );

    final resultJson = await graphQl.send(eventsQuery);

    final eventsJson = resultJson['data']['events'];

    final List<Event> listOfEvents = eventsJson
        .map((eventJson) => Event.fromJson(eventJson))
        .cast<Event>()
        .toList();

    return listOfEvents.reversed.toList();
  }

  @override
  Future<String> bookEvent(String eventId, {@required String token}) async {
    try{
      final bookEventMutation = graphql_mutation.bookEvent(eventId);

      final resultJson = await graphQl.send(bookEventMutation, token: token);

      final bookingJson = resultJson['data']['bookEvent'];

      return bookingJson['_id'] as String;
    } on ServerException catch (error){
      throw BookEventException(error.messages);
    }
  }

  @override
  Future<void> cancelBooking(String bookingId, {@required String token}) async {
    // TODO: implement cancelBooking
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> getBookings({@required String token}) async {
    // TODO: implement getBookings
    throw UnimplementedError();
  }
}
