import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/api/routes/routes_name.dart';
import 'package:test_project/constants/colors.dart';
import 'package:test_project/constants/dimensions.dart';
import 'package:test_project/constants/styles.dart';
import 'package:test_project/constants/texts.dart';
import 'package:test_project/providers/login_provider.dart';
import 'package:test_project/providers/profile_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            AppTexts.authorization,
            style: appBarTextStyle,
          ),
          border: null,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildForm(context),
                  _buildButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildForm(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    return Container(
      color: AppColor.whiteColor,
      padding: kDefaultHorizontalPadding,
      margin: const EdgeInsets.only(bottom: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoTextField.borderless(
            placeholderStyle: inputHintTextStyle,
            style: inputTextStyle,
            placeholder: AppTexts.loginOrEmail,
            padding: kDefaultVerticalPadding,
            controller: provider.loginController,
          ),
          const Divider(),
          CupertinoTextField.borderless(
            placeholderStyle: inputHintTextStyle,
            style: inputTextStyle,
            placeholder: AppTexts.password,
            obscureText: true,
            padding: kDefaultVerticalPadding,
            controller: provider.passwordController,
          ),
        ],
      ),
    );
  }

  _buildButtons(BuildContext context) => Padding(
        padding: kDefaultHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              onPressed: () {
                _handleLoginError(context);
              },
              color: AppColor.violetColor,
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Text(
                AppTexts.login,
                style: elevatedButtonTextStyle,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CupertinoButton(
              onPressed: () {},
              color: AppColor.violetColor,
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Text(
                AppTexts.register,
                style: elevatedButtonTextStyle,
              ),
            ),
          ],
        ),
      );

  _handleLoginError(BuildContext context) {
    final provider = context.read<LoginProvider>();
    provider.login((p0) {
      context.read<ProfileProvider>().setUserData(p0.user);
      _navigateMainTabPage(context);
    }, (p0) {
      _showErrorAlert(context, p0);
    });
  }

  _navigateMainTabPage(BuildContext context) async {
    await Navigator.of(context).pushReplacementNamed(AppRouteName.main);
  }

  _showErrorAlert(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(message),
          actions: [
            CupertinoButton(
              child: const Text(
                "done",
                textAlign: TextAlign.center,
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
