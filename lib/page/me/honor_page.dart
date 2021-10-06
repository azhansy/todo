import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/widget/todo_scaffold.dart';

import 'controller/honor_controller.dart';

///
/// @author dashu
/// @date 10/5/21
/// describe:
///
class HonorPage extends StatelessWidget {
  static const String routeName = '/HonorPage';
  static const String showTips = '未来会有更多的视图、月图等\n个性化大数据分析';

  HonorPage({Key? key}) : super(key: key);

  final HonorController _honorController = Get.put(HonorController());

  @override
  Widget build(BuildContext context) {
    return TodoScaffold(
      title: 'TODO 大数据分析',
      actions: [
        IconButton(
          onPressed: () {
            showTips.toast();
          },
          icon: const Icon(Icons.notifications_active_outlined),
          tooltip: showTips,
        )
      ],
      body: Center(
        child: GestureDetector(
          onTap: () {
            _honorController.queryDoneCount();
          },
          child: Container(
            height: 200.0.w,
            width: 200.0.w,
            decoration: 100.boxDecoration(Get.theme.primaryColor),
            child: Center(
              child: Text(
                '数据中心',
                style: 30.textStyle(Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
