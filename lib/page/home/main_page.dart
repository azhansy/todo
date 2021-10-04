import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tobo/page/login/widget/drawer_widget.dart';

import '../../r.g.dart';
import 'controller/main_controller.dart';
import 'input_page.dart';

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
        child: _buildList(context),
      ),
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String? content =
              await NavigatorUtil.pushName(InputPage.routeName);
          if (!TextUtil.isEmpty(content)) {
            _mainController.addTobo(content!);
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildList(BuildContext context) {
    return RefreshWidget(
      child: Obx(() => _mainController.list.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  R.svg.asset.logo.assetName,
                  color: Get.theme.primaryColor,
                  width: 100.0,
                  height: 100.0,
                ),
                10.sizedBoxH,
                Text(
                  'Write your first plan!',
                  style: 20.textStyle(Get.theme.primaryColor),
                ),
              ],
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      // SlidableAction(
                      //   onPressed: (context) {
                      //   },
                      //   foregroundColor: Colors.white,
                      //   backgroundColor: Get.theme.primaryColor,
                      //   icon: Icons.done,
                      //   label: 'Edit',
                      // ),
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) {
                          _mainController.updateToboDone(index);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Done',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(_mainController.list[index].content),
                  ),
                );
              },
              itemCount: _mainController.list.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  color: Get.theme.primaryColor.withOpacity(0.1),
                );
              },
            )),
    );
  }
}
