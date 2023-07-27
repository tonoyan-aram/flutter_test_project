import 'package:test_project/api/models/auth/login/logged_model.dart';

abstract class LoginService {
  Future<LoggedModel> login(String email, String password);
}
