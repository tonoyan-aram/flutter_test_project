import 'package:flutter/cupertino.dart';
import 'package:test_project/api/base/client_base.dart';
import 'package:test_project/api/base/end_points.dart';
import 'package:test_project/api/base/response.dart';
import 'package:test_project/api/models/auth/login/logged_model.dart';
import 'package:test_project/api/util/shared.dart';
import 'package:test_project/services/auth/login_service.dart';

class LoginServiceBase implements LoginService {
  final ApiBaseClient _apiBaseClient = ApiBaseClient();

  @override
  Future<LoggedModel> login(String email, String password) async {
    return await _apiBaseClient.postRequest(EndPoint.login,
        body: {"email": email, "password": password}).then((value) {
      if (value.statusCode == 200 && value.data != null) {
        Map<String, dynamic> data = value.data;
        return data;
      }
      return null;
    }).then((value) {
      if (value != null && value.isNotEmpty) {
        LoggedModel loggedModel = LoggedModel.fromJson(value);
        SharedPreference().token = loggedModel.tokens.access;
        SharedPreference().userInfo = [
          loggedModel.user.id.toString(),
          loggedModel.user.email,
          loggedModel.user.nickname
        ];
        debugPrint(loggedModel.toJson().toString());
        return loggedModel;
      }
      throw ApiError.warning();
    }).catchError((e) {
      ApiError err = e;
      throw err;
    });
  }
}
