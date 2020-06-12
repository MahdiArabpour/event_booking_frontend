class Validator{
  String validateEmail(String email) {
    if(email.isEmpty) return "Email is required.";
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(email)) ? null : "Invalid email address.";
  }

  validatePassword(String password){
    if(password.isEmpty) return "Password can't be empty.";
    if(password.length <= 6) return "Password must be at least 6 characters";
    return null;
  }
}