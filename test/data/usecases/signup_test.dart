import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/datasources/graphql.dart';
import 'package:event_booking/src/data/models/user.dart';
import 'package:event_booking/src/data/usecases/signup.dart';
import 'package:event_booking/core/utils/graphql/queries.dart' as graphql_query;

class MockGraphQl extends Mock implements GraphQl {}

void main() {
  MockGraphQl graphQl;
  SignUp signUp;

  setUp(() {
    graphQl = MockGraphQl();
    signUp = SignUp(graphQl: graphQl);
  });

  group('SignUp', () {
    final email = 'test1@test.com';
    final password = 'test';
    final signUpQuery = graphql_query.signUp(email, password);

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

        await signUp(email, password);

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

        final user = await signUp(email, password);

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
            .thenThrow(ServerException(message: 'User already exists'));

        expect(
          () => signUp(email, password),
          throwsA(TypeMatcher<SignUpUserException>()),
        );
      },
    );

    test(
      'Throws a SignupException when the status code is 200 but body contains some errors',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "errors": [
                {
                  "message": "User already Exists",
                  "locations": [
                    {"line": 1, "column": 10}
                  ],
                  "path": ["createUser"]
                }
              ],
              "data": {"createUser": null}
            });

        expect(
          () => signUp(email, password),
          throwsA(TypeMatcher<SignUpUserException>()),
        );
      },
    );

    test(
      'Throws a SignupException with the currect List of errorMessages',
      () async {
        when(graphQl.send(any)).thenAnswer((realInvocation) async => {
              "errors": [
                {
                  "message": "User already Exists",
                  "locations": [
                    {"line": 1, "column": 10}
                  ],
                  "path": ["createUser"]
                }
              ],
              "data": {"createUser": null}
            });

        final expectedErrorList = ["User already Exists"];

        try {
          await signUp(email, password);
        } catch (error) {
          expect(error.messages, expectedErrorList);
        }
      },
    );
  });
}
