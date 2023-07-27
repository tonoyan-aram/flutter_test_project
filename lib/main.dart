import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:test_project/api/routes/routes.dart';
import 'package:test_project/api/routes/routes_name.dart';
import 'package:test_project/api/util/navigator_key.dart';
import 'package:test_project/api/util/shared.dart';
import 'package:test_project/constants/colors.dart';
import 'package:test_project/providers/login_provider.dart';
import 'package:test_project/providers/profile_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference().getInstance();
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..boxShadow = [
      BoxShadow(
        color: AppColor.blackColor.withOpacity(0.1),
        offset: const Offset(1.0, 2.0),
        blurRadius: 50.0,
      )
    ]
    ..backgroundColor = AppColor.whiteColor
    ..indicatorColor = AppColor.violetColor
    ..maskColor = AppColor.blackColor.withOpacity(0.2)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _sharedPrefManager = SharedPreference();
  String? initialRoute;

  @override
  void initState() {
    super.initState();
    _sharedPrefManager.getInstance();
    _checkUserLoginState();
  }

  _checkUserLoginState() {
    if (_sharedPrefManager.token.isEmpty) {
      _sharedPrefManager.removeAll();
      initialRoute = AppRouteName.login;
    } else {
      initialRoute = AppRouteName.main;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigatorKey.globalKey,
        theme: const CupertinoThemeData(
            scaffoldBackgroundColor: AppColor.scaffoldBgColor,
            barBackgroundColor: AppColor.whiteColor,
            primaryColor: AppColor.violetColor),
        title: 'Test App',
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoutes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
