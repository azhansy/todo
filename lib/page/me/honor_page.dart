import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/widget/container_body.dart';

import 'controller/honor_controller.dart';

///
/// @author dashu
/// @date 10/5/21
/// describe:
///
class HonorPage extends StatelessWidget {
  static const String routeName = '/HonorPage';

  HonorPage({Key? key}) : super(key: key);

  final HonorController _honorController = Get.put(HonorController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Honor Roll',
      body: ContainerBody(
          child: Center(
        child: Container(
          height: 200.0,
          width: 200.0,
          decoration: 100.boxDecoration(Get.theme.primaryColor),
          child: Center(
            child: Text(
              '数据分析中...',
              style: 15.textStyle(Colors.white),
            ),
          ),
        ),
      )),
    );
  }
}
