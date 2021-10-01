import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/page/login_page.dart';

///
/// @author dashu
/// @date 10/1/21
/// describe:
///
class SplashPage extends BaseUnView {
  static const String routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  void onReady() {
    super.onReady();
    3.delay(() {
      NavigatorUtil.offAllNamed(LoginPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('splash')),
      ),
    );
  }
}
