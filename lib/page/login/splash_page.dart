import 'dart:math';

import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobo/page/home/main_page.dart';
import 'package:tobo/res/colors.dart';

import 'package:vector_math/vector_math_64.dart' hide Colors;

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
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() => setState(() {}));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        NavigatorUtil.offAllNamed(MainPage.routeName);
      }
    });
    animation = Tween<double>(
      begin: 50.0,
      end: 120.0,
    ).animate(animationController);

    animationController.forward();
  }

  Vector3 _shake() {
    final double progress = animationController.value;
    final double offset = sin(progress * pi * 20.0);
    return Vector3(
      offset * Random().nextInt(4),
      offset * Random().nextInt(2),
      offset * Random().nextInt(2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBg,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TODO',
                  style: 18.textStyle(Colors.white),
                ),
                30.sizedBoxH,
                Center(
                  child: Transform(
                    transform: Matrix4.translation(_shake()),
                    child: SvgPicture.asset(
                      R.svg.asset.logo.assetName,
                      color: Colors.white,
                      width: 58.w,
                      height: 58.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
