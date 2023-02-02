class TextFieldValidator {
  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isEmptyOrNull(String? str) {
    return (str == null || str.trim().isEmpty);
  }

  static bool isAtLeastSixCharactersLong(String str) {
    return RegExp(r'^.{6,}$').hasMatch(str);
  }
}
