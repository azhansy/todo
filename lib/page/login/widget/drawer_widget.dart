import 'package:awesome_core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tobo/common/application.dart';
import 'package:tobo/page/home/controller/main_controller.dart';
import 'package:tobo/page/login/login_page.dart';
import 'package:tobo/page/me/about_page.dart';
import 'package:tobo/page/me/feedback_page.dart';
import 'package:tobo/page/me/honor_page.dart';
import 'package:tobo/page/me/theme_page.dart';
import 'package:tobo/res/colors.dart';

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
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Application.instance.getBmobUser()?.username ??
                              'User',
                          style: 15.textStyle(Colours.color_white),
                        ),
                        10.sizedBoxH,
                        Text(
                          _getHi(),
                          style: 10.textStyle(Colours.color_666666),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    left: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        NavigatorUtil.pushName(HonorPage.routeName);
                        // MainController controller = Get.find();
                        // controller.queryDoneCount();
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.data_usage,
                          color: Get.theme.primaryColor,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
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
          const Divider(),
          ListTile(
            title: const Text('Feedback'),
            onTap: () {
              // NavigatorUtil.pop();
              NavigatorUtil.pushName(FeedbackPage.routeName);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('About App'),
            onTap: () {
              // NavigatorUtil.pop();
              NavigatorUtil.pushName(AboutPage.routeName);
            },
          ),
          const Spacer(),
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

  String _getHi() {
    final DateTime tmCur = DateTime.now();

    if (tmCur.hour < 8 || tmCur.hour > 23) {
      //??????
      return '?????????????????????????????????????????????';
    }
    if (tmCur.hour < 8 || tmCur.hour > 18) {
      //??????
      return 'Good Evening';
    } else if (tmCur.hour >= 8 && tmCur.hour < 12) {
      //??????
      return 'Good Morning';
    }
    //??????
    return 'Good Afternoon';
  }
}
