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

  group('Events validator', (){
    test('returns the right error message when some fields are empty', () async {
      final message1 = await validator.validateEventInputs();

      final expectedMessage1 = 'Please enter title, description and price';

      expect(message1, expectedMessage1);


      final message2 = await validator.validateEventInputs(title: "test");

      final expectedMessage2 = 'Please enter description and price';

      expect(message2, expectedMessage2);


      final message3 = await validator.validateEventInputs(description: "test description");

      final expectedMessage3 = 'Please enter title and price';

      expect(message3, expectedMessage3);


      final message4 = await validator.validateEventInputs(price: "84.99");

      final expectedMessage4 = 'Please enter title and description';

      expect(message4, expectedMessage4);


      final message5 = await validator.validateEventInputs(title: "test", description: "test description");

      final expectedMessage5 = 'Please enter a price';

      expect(message5, expectedMessage5);


      final message6 = await validator.validateEventInputs(title: "test", price: "84.99");

      final expectedMessage6 = 'Please enter a description';

      expect(message6, expectedMessage6);


      final message7 = await validator.validateEventInputs(description: "test description", price: "84.99");

      final expectedMessage7 = 'Please enter a title';

      expect(message7, expectedMessage7);
    });

    test('returns null when all fields are given', () async {
      final message = await validator.validateEventInputs(title: "test", description: "test description", price: "84.99");
      expect(message, isNull);
    });
  });
}
