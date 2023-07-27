import 'package:flutter/cupertino.dart';
import 'package:test_project/api/routes/routes_name.dart';
import 'package:test_project/screens/auth/login_page.dart';
import 'package:test_project/screens/main/main_page.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRouteName.main:
      return _buildRoute(const MainPage(), settings);
    case AppRouteName.login:
      return _buildRoute(const LoginPage(), settings);
    default:
      return _buildRoute(const LoginPage(), settings);
  }
}

_buildRoute(Widget widget, RouteSettings settings) {
  return CupertinoPageRoute(builder: (context) => widget, settings: settings);
}
