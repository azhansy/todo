import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tobo/page/login/splash_page.dart';

import 'common/application.dart';
import 'page/home/main_page.dart';
import 'page/login/login_page.dart';
import 'page/login/register_page.dart';

class AppPages {
  static const initial = SplashPage.routeName;

  static final List<GetPage<Widget>> routes = [
    GetPage<Widget>(
      name: SplashPage.routeName,
      page: () => const SplashPage(),
    ),
    GetPage<Widget>(
      name: RegisterPage.routeName,
      page: () =>  RegisterPage(),
    ),
    GetPage<Widget>(
      name: LoginPage.routeName,
      page: () => const LoginPage(),
    ),
    GetPage<Widget>(
        name: MainPage.routeName,
        page: () => const MainPage(),
        middlewares: [AuthMiddleware()]),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Application.instance.isLogin
        ? super.redirect(route)
        : const RouteSettings(name: LoginPage.routeName);
  }
}
