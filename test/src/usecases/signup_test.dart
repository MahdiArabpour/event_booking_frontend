import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/models/user.dart';
import 'package:event_booking/src/data/repositories/event_booking_repository_impl.dart';
import 'package:event_booking/src/usecases/signup.dart';

class MockEventBookingRepository extends Mock
    implements EventBookingRepositoryImpl {}

void main() {
  MockEventBookingRepository repository;
  SignUp signUp;

  setUp(() {
    repository = MockEventBookingRepository();
    signUp = SignUp(repository: repository);
  });

  final email = 'test1@test.com';
  final password = 'test';
  final user = User(
        (b) => b
      ..id = "SomeId"
      ..email = email,
  );

  test(
    'signs up the user',
    () async {
      when(repository.signup(any, any))
          .thenAnswer((realInvocation) async => user);

      signUp(email,password);

      verify(repository.signup(email,password));
    },
  );


  test(
    'Returns the right User object when the signup is successful',
    () async {
      when(repository.signup(any, any))
          .thenAnswer((realInvocation) async => user);

      final signedUpUser = await signUp(email, password);

      final expectedUser = User(
            (b) => b
          ..id = "SomeId"
          ..email = email,
      );

      expect(
        signedUpUser,
        expectedUser,
      );
    },
  );

  test(
    'Throws a UserAlreadyExistsException when the server response is user exists',
    () async {
      when(repository.signup(any, any))
          .thenThrow(SignUpUserException(["User already Exists"]));

      expect(
        () => signUp(email, password),
        throwsA(TypeMatcher<UserAlreadyExistException>()),
      );
    },
  );

  test(
    'Throws an UnknownServerException when there is an unknown error',
    () async {
      when(repository.signup(any, any))
          .thenThrow(SignUpUserException());

      expect(
        () => signUp(email, password),
        throwsA(TypeMatcher<UnknownServerException>()),
      );


      when(repository.signup(any, any))
          .thenThrow(SignUpUserException(["some unknown error message"]));


      expect(
            () => signUp(email, password),
        throwsA(TypeMatcher<UnknownServerException>()),
      );
    },
  );
}
