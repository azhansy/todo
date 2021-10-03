import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tobo/page/login/widget/drawer_widget.dart';

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
      child: Obx(() => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 2,
                      onPressed: (context) {
                        _mainController.updateToboDone(index);
                      },
                      backgroundColor: Get.theme.primaryColor,
                      foregroundColor: Colors.white,
                      icon: Icons.done,
                      label: 'Done',
                    ),
                    // SlidableAction(
                    //   onPressed: (context) {},
                    //   backgroundColor: Colors.red,
                    //   foregroundColor: Colors.white,
                    //   icon: Icons.delete,
                    //   label: 'Delete',
                    // ),
                  ],
                ),
                child: ListTile(
                  title: Text(_mainController.list[index].content),
                ),
              );
            },
            itemCount: _mainController.list.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          )),
    );
  }
}
