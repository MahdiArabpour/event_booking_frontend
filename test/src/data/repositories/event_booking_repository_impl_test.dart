import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:event_booking/src/data/models/user.dart';
import 'package:event_booking/src/data/models/event.dart';
import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:event_booking/src/data/datasources/graphql.dart';
import 'package:event_booking/src/data/repositories/remote_data_source_repository_impl.dart';
import 'package:event_booking/core/utils/graphql/queries.dart' as graphql_query;
import 'package:event_booking/core/utils/graphql/mutations.dart'
    as graphql_mutation;

class MockGraphQl extends Mock implements GraphQl {}

void main() {
  MockGraphQl graphQl;
  RemoteDataSourceRepositoryImpl repository;

  setUp(() {
    graphQl = MockGraphQl();
    repository = RemoteDataSourceRepositoryImpl(graphQl: graphQl);
  });

  group('Login', () {
    final email = 'test1@test.com';
    final password = 'test';
    final loginQuery = graphql_query.login(email, password);

    test(
      'sends login information to the graphql server',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "login": {
                  "userId": "5ee34fabd5f5bc0017e9b5c5",
                  "token":
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWUzNGZhYmQ1ZjViYzAwMTdlOWI1YzUiLCJlbWFpbCI6IkBlbWFpbCIsImlhdCI6MTU5MTk1NzE0NSwiZXhwIjoxNTkxOTYwNzQ1fQ.8SC9NRIIv_H3KogVw4cZxPt4-txELd1Fm3lCWYYbDh0",
                  "tokenExpiration": 1
                }
              }
            });

        await repository.login(email, password);

        verify(graphQl.send(loginQuery));
      },
    );

    test(
      'Returns the right AuthData object when the login is successful',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "login": {
                  "userId": "5ee34fabd5f5bc0017e9b5c5",
                  "token":
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWUzNGZhYmQ1ZjViYzAwMTdlOWI1YzUiLCJlbWFpbCI6IkBlbWFpbCIsImlhdCI6MTU5MTk1NzE0NSwiZXhwIjoxNTkxOTYwNzQ1fQ.8SC9NRIIv_H3KogVw4cZxPt4-txELd1Fm3lCWYYbDh0",
                  "tokenExpiration": 1
                }
              }
            });

        final authData = await repository.login(email, password);

        final expectedAuthData = AuthData((b) => b
          ..userId = "5ee34fabd5f5bc0017e9b5c5"
          ..token =
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWUzNGZhYmQ1ZjViYzAwMTdlOWI1YzUiLCJlbWFpbCI6IkBlbWFpbCIsImlhdCI6MTU5MTk1NzE0NSwiZXhwIjoxNTkxOTYwNzQ1fQ.8SC9NRIIv_H3KogVw4cZxPt4-txELd1Fm3lCWYYbDh0"
          ..tokenExpiration = 1);

        expect(
          authData,
          expectedAuthData,
        );
      },
    );

    test(
      'Throws a LoginUserException when the status code is not 200',
      () async {
        when(graphQl.send(any))
            .thenThrow(ServerException(messages: ['User does not exist']));

        expect(
          () => repository.login(email, password),
          throwsA(TypeMatcher<LoginUserException>()),
        );
      },
    );
  });

  group('SignUp', () {
    final email = 'test1@test.com';
    final password = 'test';
    final signUpQuery = graphql_mutation.signUp(email, password);

    test(
      'sends signup information to the graphql server',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "createUser": {
                  "_id": "5ede58b19a9ba33ce83ee0b3",
                  "email": "test1@test.com"
                }
              }
            });

        await repository.signup(email, password);

        verify(graphQl.send(signUpQuery));
      },
    );

    test(
      'Returns the right User object when the signup is successful',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "createUser": {
                  "_id": "5ede58b19a9ba33ce83ee0b3",
                  "email": "test1@test.com"
                }
              }
            });

        final user = await repository.signup(email, password);

        final expectedUser = User((b) => b
          ..id = "5ede58b19a9ba33ce83ee0b3"
          ..email = "test1@test.com");

        expect(
          user,
          expectedUser,
        );
      },
    );

    test(
      'Throws a SignUpUserException when the status code is not 200',
      () async {
        when(graphQl.send(any))
            .thenThrow(ServerException(messages: ['User already exists']));

        expect(
          () => repository.signup(email, password),
          throwsA(TypeMatcher<SignUpUserException>()),
        );
      },
    );
  });

  group('getEvents', () {
    final eventsQuery = graphql_query.getEvents(
      id: true,
      title: true,
      description: true,
      date: true,
      price: true,
      creator: true,
    );

    test(
      'sends event query to graphql',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "events": [
                  {
                    "title": "test1",
                    "description": "test1 description",
                    "price": 9.99,
                    "date": "2020-06-05T11:42:38.585Z",
                    "creator": {"email": "test@test.com"}
                  },
                  {
                    "title": "test2",
                    "description": "test2 description",
                    "price": 9.99,
                    "date": "2020-06-05T11:42:38.585Z",
                    "creator": {"email": "test@test.com"}
                  }
                ]
              }
            });

        await repository.getEvents();

        verify(graphQl.send(eventsQuery));
      },
    );

    test(
      'Returns the right List of Event objects when there was some data returned by graphql',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "events": [
                  {
                    "title": "test1",
                    "description": "test1 description",
                    "price": 9.99,
                    "date": "2020-06-05T11:42:38.585Z",
                    "creator": {"email": "test@test.com"}
                  },
                  {
                    "title": "test2",
                    "description": "test2 description",
                    "price": 9.99,
                    "date": "2020-06-05T11:42:38.585Z",
                    "creator": {"email": "test@test.com"}
                  }
                ]
              }
            });

        final events = await repository.getEvents();

        final expectedEvents = [
          Event.fromJson({
            "title": "test1",
            "description": "test1 description",
            "price": 9.99,
            "date": "2020-06-05T11:42:38.585Z",
            "creator": {"email": "test@test.com"}
          }),
          Event.fromJson({
            "title": "test2",
            "description": "test2 description",
            "price": 9.99,
            "date": "2020-06-05T11:42:38.585Z",
            "creator": {"email": "test@test.com"}
          }),
        ].reversed.toList();

        expect(
          events,
          expectedEvents,
        );
      },
    );
  });

  group('postEvents', () {
    final id = "AnId";
    final title = "test";
    final description = "test description";
    final price = 9.99;
    final date = DateTime.now();

    final eventsMutation = graphql_mutation.createEvent(
      title: title,
      description: description,
      price: price,
      dateISOString: date.toIso8601String(),
    );

    test(
      'sends event mutation to graphql',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "createEvent": {
                  "_id": id,
                  "creator": {"email": "me@me.com"},
                }
              }
            });

        await repository.postEvent(
            Event((b) => b
              ..title = title
              ..description = description
              ..price = price
              ..date = date),
            token: "");

        verify(graphQl.send(eventsMutation));
      },
    );

    test(
      'Returns the right List of Event objects when there was some data returned by graphql',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "data": {
                "createEvent": {
                  "_id": id,
                  "creator": {"email": "me@me.com"}
                }
              }
            });

        final createdEvent = await repository.postEvent(
            Event((b) => b
              ..title = title
              ..description = description
              ..price = price
              ..date = date),
            token: "");

        final expectedEvent = Event(
          (b) => b
            ..id = id
            ..title = title
            ..description = description
            ..price = price
            ..date = createdEvent.date
            ..creator = User((b) => b..email = "me@me.com").toBuilder(),
        );

        expect(
          createdEvent,
          expectedEvent,
        );
      },
    );

  });
}
