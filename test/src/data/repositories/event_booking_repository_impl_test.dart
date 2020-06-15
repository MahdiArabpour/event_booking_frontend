import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/datasources/graphql.dart';
import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:event_booking/src/data/repositories/event_booking_repository_impl.dart';
import 'package:event_booking/src/data/models/user.dart';
import 'package:event_booking/core/utils/graphql/queries.dart' as graphql_query;
import 'package:event_booking/core/utils/graphql/mutations.dart'
    as graphql_mutation;

class MockGraphQl extends Mock implements GraphQl {}

void main() {
  MockGraphQl graphQl;
  EventBookingRepositoryImpl repository;

  setUp(() {
    graphQl = MockGraphQl();
    repository = EventBookingRepositoryImpl(graphQl: graphQl);
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
}
