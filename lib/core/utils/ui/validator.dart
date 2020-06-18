class Validator {
  String validateEmail(String email) {
    if (email.isEmpty) return "Email is required.";
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(email)) ? null : "Invalid email address.";
  }

  String validatePassword(String password) {
    if (password.isEmpty) return "Password can't be empty.";
    if (password.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String validateConfirmPasswordEquality(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return "confirm password can't be empty.";
    if (password == confirmPassword) return null;
    return "Confirm password doesn't match password";
  }

  Future<String> validateEventInputs({
    String title = '',
    String description = '',
    String price = '',
  }) async {

    final parsedPrice = double.tryParse(price);

    if(price != '' && (parsedPrice == null || parsedPrice < 0.0)) return 'Price must be a positive number!';

    final emptyFields = [
      if (title.isEmpty) 'title',
      if (description.isEmpty) 'description',
      if (price.isEmpty) 'price'
    ];

    if (emptyFields.isEmpty) return null;

    String joined;

    if (emptyFields.length == 1)
      joined = 'a ${emptyFields[0]}';
    else
      joined = _joinEmptyFields(emptyFields);

    return 'Please enter $joined';
  }

  String _joinEmptyFields(List<String> emptyFields) {
    String joined = emptyFields.join(', ');

    var i;
    for (i = joined.length - 1; i >= 0; i--) {
      if (joined[i] == ' ') break;
    }

    return joined.replaceRange(i - 1, i, ' and');
  }
}
