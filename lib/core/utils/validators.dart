
class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return "Email shouldn't be empty";
    }
    final RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    if (!regExp.hasMatch(val)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return "Password shouldn't be empty";
    }
    if (val.length < 8) {
      return "Password should be at least 8 characters";
    }
    return null;
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return "Confirm password shouldn't be empty";
    }
    if (val != password) {
      return "Passwords don't match";
    }
    return null;
  }

  static String? validateUsername(String? val) {
    if (val == null || val.isEmpty) {
      return "Username shouldn't be empty";
    }
    return null;
  }

  static String? validatePhone(String? val) {
    if (val == null || val.isEmpty) {
      return "Phone shouldn't be empty";
    }
    if (val.length < 11) {
      return "Phone should be at least 11 digits";
    }
    return null;
  }
}
