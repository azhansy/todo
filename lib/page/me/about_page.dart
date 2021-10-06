import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/res/colors.dart';
import 'package:tobo/widget/todo_scaffold.dart';

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
    final indent = (Get.width - 40.w) / 2;
    return TodoScaffold(
      title: 'About App',
      body: Column(
        children: [
          100.sizedBoxH,
          Expanded(
            child: Text(
              '今天的todo，让你充实每一天\n'
              '明天的todo，让你的未来一直优秀',
              style: 18.textStyle(
                Colours.color_333333,
                height: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              '格比飞勇@V${BaseConfig.VERSION_CODE}',
              style: 10.textStyle(Colours.gray_99),
            ),
          ),
          Divider(
            endIndent: indent,
            indent: indent,
          ),
          Center(
            child: Text(
              '永久保存、记录自己的成长心路历程，是一件很有意义的事情。',
              style: 8.textStyle(Colours.gray_99),
            ),
          ),
          30.sizedBoxH,
        ],
      ),
    );
  }
}
