import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/page/home/main_page.dart';

import '../../r.g.dart';

///
/// @author dashu
/// @date 10/1/21
/// describe:
///
class SplashPage extends StatefulWidget {
  static const String routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        NavigatorUtil.offAllNamed(MainPage.routeName);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor.withOpacity(0.5),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TODO',
                style: 18.textStyle(Colors.white),
              ),
              30.sizedBoxH,
              Image.asset(
                R.image.asset.logo.assetName,
                scale: 1.2,
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
