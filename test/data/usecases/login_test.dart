import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/datasources/graphql.dart';
import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:event_booking/src/data/usecases/login.dart';
import 'package:event_booking/core/utils/graphql/queries.dart' as graphql_query;

class MockGraphQl extends Mock implements GraphQl {}

void main() {
  MockGraphQl graphQl;
  Login login;

  setUp(() {
    graphQl = MockGraphQl();
    login = Login(graphQl: graphQl);
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

        await login(email, password);

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

        final authData = await login(email, password);

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
            .thenThrow(ServerException(message: 'User already exists'));

        expect(
          () => login(email, password),
          throwsA(TypeMatcher<LoginUserException>()),
        );
      },
    );

    test(
      'Throws a LoginUserException when the status code is 200 but body contains some errors',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "errors": [
                {
                  "message": "User does not exist",
                  "locations": [
                    {"line": 1, "column": 7}
                  ],
                  "path": ["login"]
                }
              ],
              "data": null
            });

        expect(
          () => login(email, password),
          throwsA(TypeMatcher<LoginUserException>()),
        );
      },
    );

    test(
      'Throws a LoginUserError with the currect List of errorMessages',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "errors": [
                {
                  "message": "User does not exist",
                  "locations": [
                    {"line": 1, "column": 7}
                  ],
                  "path": ["login"]
                }
              ],
              "data": null
            });

        final expectedErrorList = ["User does not exist"];

        try {
          await login(email, password);
        } catch (error) {
          expect(error.messages, expectedErrorList);
        }
      },
    );
  });
}
