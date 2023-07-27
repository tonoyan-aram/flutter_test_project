import 'package:flutter/material.dart';
import 'package:test_project/api/models/auth/user/user_model.dart';
import 'package:test_project/api/routes/routes_name.dart';
import 'package:test_project/api/util/navigator_key.dart';
import 'package:test_project/api/util/shared.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    List<String> userInfo = SharedPreference().userInfo;
    if (userInfo.isNotEmpty) {
      _userModel = UserModel.init(userInfo);
    }
  }

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  setUserData(UserModel newValue) {
    _userModel = newValue;
  }

  logout() {
    debugPrint("logout");
    SharedPreference().removeAll();
    BuildContext? context = NavigatorKey.globalKey.currentContext;
    if (context != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouteName.login, (route) => false);
    }
  }
}
