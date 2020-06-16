import 'package:event_booking/core/utils/ui/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Validator validator;
  setUp(() {
    validator = Validator();
  });

  group('email Validator', () {
    test('returns error String when email is invalid', () {
      final invalidEmailList = [
        "test",
        "test@gmail.",
        "test@gmail",
        "tes#t@gmail",
        "tes%t@gmail",
        "test;f@gmail.com",
        "testgmail.com",
        "@gmail.com",
      ];

      for (var emailAddress in invalidEmailList)
        expect(validator.validateEmail(emailAddress), "Invalid email address.");
    });

    test('returns appropriate String when email is empty', () {
      expect(validator.validateEmail(""), "Email is required.");
    });

    test('returns null when email is valid', () {
      final invalidEmailList = [
        "mahdi@gmail.com",
        "mahdi@outlook.com",
        "mahdi@yahoo.com",
        "mahdi@ymail.com",
      ];

      for (var emailAddress in invalidEmailList)
        expect(validator.validateEmail(emailAddress), null);
    });
  });

  group('password Validator', () {
    test(
        'returns appropriate error String when password is less than 6 characters',
        () {
      expect(validator.validatePassword("12345"),
          "Password must be at least 6 characters");
    });

    test('returns appropriate String when password is empty', () {
      expect(validator.validatePassword(""), "Password can't be empty.");
    });

    test('returns null when password is valid', () {
      expect(validator.validatePassword("password"), isNull);
    });
  });
}
