import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tobo/page/login/splash_page.dart';

import 'common/application.dart';
import 'page/login_page.dart';

class AppPages {
  static const initial = SplashPage.routeName;

  static final List<GetPage<Widget>> routes = [
    GetPage<Widget>(
      name: SplashPage.routeName,
      page: () => const SplashPage(),
    ),
    GetPage<Widget>(
      name: LoginPage.routeName,
      page: () => const LoginPage(),
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Application.instance.isLogin
        ? null
        : const RouteSettings(name: LoginPage.routeName);
  }
}
