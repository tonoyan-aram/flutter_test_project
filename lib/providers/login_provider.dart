import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:test_project/api/base/response.dart';
import 'package:test_project/api/models/auth/login/logged_model.dart';
import 'package:test_project/api/util/validation.dart';
import 'package:test_project/constants/texts.dart';
import 'package:test_project/services/auth/login_service_base.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController _loginController = TextEditingController();

  TextEditingController get loginController => _loginController;

  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;

  _reset() {
    _loginController.clear();
    _passwordController.clear();
  }

  Future<void> login(
      Function(LoggedModel) success, Function(String) fail) async {
    debugPrint(_loginController.text);
    debugPrint(_passwordController.text);

    if (!isEmailValidate(_loginController.text)) {
      fail(AppTexts.emailValidation);
      return;
    }

    if (!isPasswordValidate(_passwordController.text)) {
      fail(AppTexts.passwordError);
      return;
    }

    await EasyLoading.show();
    await LoginServiceBase()
        .login(_loginController.text, _passwordController.text)
        .then((value) async {
      await EasyLoading.dismiss();
      _reset();
      success(value);
    }).catchError((e) async {
      await EasyLoading.dismiss();
      ApiError error = e;
      fail(error.message?.replaceAll("\"", "") ?? "");
    });
  }
}
