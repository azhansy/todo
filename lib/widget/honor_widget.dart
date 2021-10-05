import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobo/res/colors.dart';

import '../r.g.dart';

///
/// @author dashu
/// @date 10/5/21
/// describe:
///
class HonorWidget extends Dialog {
  final int count;

  const HonorWidget(this.count, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: 20.roundedDecoration(Get.theme.primaryColor),
          margin: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          width: double.infinity,
          height: 400.0.h,
          child: Column(
            children: [
              SvgPicture.asset(
                R.svg.asset.ic_honor.assetName,
                width: 200.0,
                height: 200.0,
              ),
              Text(
                '太棒了！',
                style: 18.textStyle(Colours.color_white),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: '你已经完成了',
                  style: 18.textStyle(Colours.color_white),
                ),
                TextSpan(
                  text: '$count',
                  style: 40.textStyle(Colours.price_red),
                ),
                TextSpan(
                  text: '个计划, \n为你自己点个赞！',
                  style: 18.textStyle(Colours.color_white),
                ),
              ])),
              30.sizedBoxH,
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: 'GREAT'.buttonOutRound(() {
                  NavigatorUtil.pop();
                }, width: double.infinity),
              )
            ],
          ),
        ),
      ),
    );
  }
}
