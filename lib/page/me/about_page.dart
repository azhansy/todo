import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/res/colors.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class AboutPage extends StatefulWidget {
  static const String routeName = '/AboutPage';

  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'About App',
      body: Container(
        height: double.infinity,
        color: Get.theme.primaryColor.withOpacity(0.1),
        child: Column(
          children: [
            100.sizedBoxH,
            Expanded(
              child: Text(
                '今天的todo让你充实每一天\n明天的todo，使你更加优秀！',
                style: 18.textStyle(Colours.color_333333),
              ),
            ),
            Center(
              child: Text(
                '格比飞勇@出品',
                style: 10.textStyle(Colours.gray_99),
              ),
            ),
            30.sizedBoxH,
          ],
        ),
      ),
    );
  }
}