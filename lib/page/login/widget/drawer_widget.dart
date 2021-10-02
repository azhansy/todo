import 'package:awesome_core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tobo/common/application.dart';
import 'package:tobo/page/login/login_page.dart';
import 'package:tobo/page/me/about_page.dart';
import 'package:tobo/page/me/theme_page.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      'Hello, ${Application.instance.getBmobUser()?.username ?? 'User'}',
                      style: 15.textStyle(Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Theme Color'),
                  onTap: () {
                    NavigatorUtil.pop();
                    NavigatorUtil.pushName(ThemePage.routeName);
                  },
                ),
                ListTile(
                  title: const Text('About App'),
                  onTap: () {
                    NavigatorUtil.pop();
                    NavigatorUtil.pushName(AboutPage.routeName);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: 'Exit'.buttonElev(() {
              NavigatorUtil.showAlertDialog(
                context,
                'Ready to exit?',
                () {
                  Application.instance.clearAuthorization();
                  NavigatorUtil.offAllNamed(LoginPage.routeName);
                },
              );
            }, radius: 20.w),
          )
        ],
      ),
    );
  }
}
