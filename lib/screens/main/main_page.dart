import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/constants/colors.dart';
import 'package:test_project/constants/images.dart';
import 'package:test_project/constants/texts.dart';
import 'package:test_project/screens/profile/profile_page.dart';
import 'package:test_project/utils/menu_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainPage> {
  CupertinoTabController controller = CupertinoTabController(initialIndex: 3);
  List<Widget> get _pages =>
      <Widget>[Container(), Container(), Container(), const ProfilePage()];

  List<MenuItem> get _menuItems => <MenuItem>[
        MenuItem(title: AppTexts.feed, icon: AppImage.feed),
        MenuItem(title: AppTexts.map, icon: AppImage.map),
        MenuItem(title: AppTexts.favorite, icon: AppImage.favorite),
        MenuItem(title: AppTexts.profile, icon: AppImage.profile),
      ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      controller: controller,
      tabBar: CupertinoTabBar(
        activeColor: AppColor.violetColor,
        inactiveColor: AppColor.blackColor,
        iconSize: 18.0,
        items: [
          for (var item in _menuItems)
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                item.icon,
                width: 18.0,
                height: 18.0,
              ),
              activeIcon: SvgPicture.asset(
                item.icon,
                color: AppColor.violetColor,
              ),
              label: item.title,
            ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return _pages[index];
          },
        );
      },
    );
  }
}
