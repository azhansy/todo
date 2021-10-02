import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/common/application.dart';
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
            ),
            child: Text(
              Application.instance.getBmobUser()?.username ?? 'User',
              style: 15.textStyle(Colors.white),
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
    );
  }
}
