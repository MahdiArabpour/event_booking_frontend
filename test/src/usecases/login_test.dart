import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:event_booking/src/data/repositories/event_booking_repository_impl.dart';
import 'package:event_booking/src/usecases/login.dart';

class MockEventBookingRepository extends Mock
    implements EventBookingRepositoryImpl {}

void main() {
  MockEventBookingRepository repository;
  Login login;

  setUp(() {
    repository = MockEventBookingRepository();
    login = Login(repository: repository);
  });

  final email = 'test1@test.com';
  final password = 'test';
  final authData = AuthData(
    (b) => b
      ..userId = "SomeId"
      ..token = "SomeToken"
      ..tokenExpiration = 1,
  );

  test(
    'logins the user',
    () async {
      when(repository.login(any, any))
          .thenAnswer((realInvocation) async => authData);

      login(email, password);

      verify(repository.login(email, password));
    },
  );

  test(
    'Returns the right AuthData object when the login is successful',
    () async {
      when(repository.login(any, any))
          .thenAnswer((realInvocation) async => authData);

      final receivedAuthData = await login(email, password);

      final expectedAutData = AuthData(
        (b) => b
          ..userId = "SomeId"
          ..token = "SomeToken"
          ..tokenExpiration = 1,
      );

      expect(
        receivedAuthData,
        expectedAutData,
      );
    },
  );

  test(
    "Throws a UserDoesNotExistException when the server response is user doesn't exist",
    () async {
      when(repository.login(any, any))
          .thenThrow(LoginUserException(["User does not exist"]));

      expect(
        () => login(email, password),
        throwsA(TypeMatcher<UserDoesNotExistException>()),
      );
    },
  );

  test(
    "Throws an IncorrectPasswordException when the server response is incorrect password",
    () async {
      when(repository.login(any, any))
          .thenThrow(LoginUserException(["Password is incorrect!"]));

      expect(
        () => login(email, password),
        throwsA(TypeMatcher<IncorrectPasswordException>()),
      );
    },
  );

  test(
    'Throws an UnknownServerException when there is an unknown error',
    () async {
      when(repository.login(any, any)).thenThrow(LoginUserException());

      expect(
        () => login(email, password),
        throwsA(TypeMatcher<UnknownServerException>()),
      );

      when(repository.login(any, any))
          .thenThrow(LoginUserException(["some unknown error message"]));

      expect(
        () => login(email, password),
        throwsA(TypeMatcher<UnknownServerException>()),
      );
    },
  );
}
