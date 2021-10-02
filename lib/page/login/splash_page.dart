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
        NavigatorUtil.pushName(MainPage.routeName);
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
    return FadeTransition(
      opacity: _animation,
      // child: Image.network(
      //   'https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1566890831&di=297a62df216c392465e93f539d9a9121&src=http://2a.zol-img.com.cn/product/73/288/ceGwVNogx6HSE.jpg',
      //   scale: 1.5,
      //   fit: BoxFit.cover,
      // ),
      child: Image.asset(
        R.image.asset.ic_splash.assetName,
        scale: 1.2,
        fit: BoxFit.cover,
      ),
    );
  }
}
