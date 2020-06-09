import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/datasources/graphql.dart';
import 'package:event_booking/src/data/models/user.dart';
import 'package:event_booking/src/data/usecases/signup.dart';

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
    final signUpQuery =
        'mutation{createUser(userInput: {email: "$email", password: "$password"}) {_id,email, }}';

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
  });
}
