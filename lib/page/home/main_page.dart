import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/page/login/widget/drawer_widget.dart';

import 'controller/main_controller.dart';
import 'input_page.dart';
import 'model/tobo.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class MainPage extends StatefulWidget {
  static const String routeName = '/MainPage';

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Get.theme.primaryColor.withOpacity(0.1),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _mainController.list
                  .map((element) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          element.content,
                          style: 20.textStyle(Colors.black),
                        ),
                      ))
                  .toList(),
            )),
      ),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String? content =
              await NavigatorUtil.pushName(InputPage.routeName);
          if (!TextUtil.isEmpty(content)) {
            _mainController.addTobo(Tobo(content!));
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
