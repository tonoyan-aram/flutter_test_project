import 'package:test_project/api/util/regExp.dart';

isEmailValidate(String email) {
  bool valid = RegExp(RegularExpressions.email).hasMatch(email) &&
      email.trim().isNotEmpty;
  return valid;
}

isPasswordValidate(String password) {
  return password.trim().isNotEmpty && password.trim().length >= 8;
}
