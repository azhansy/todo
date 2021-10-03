import 'dart:math';

import 'package:awesome_core/core.dart';
import 'package:tobo/common/database/db_manager.dart';
import 'package:tobo/net/index.dart';
import 'package:tobo/page/home/model/tobo.dart';

class MainController extends BaseController {
  RxList<Tobo> list = <Tobo>[].obs;

  Future<void> addTobo(String content) async {
    final tempTobo = Tobo(content);
    tempTobo.setObjectId(
        DateTime.now().toString() + Random().nextInt(10000).toString());
    list.add(tempTobo);
    DbManager.instance.saveOrUpdateTobo(tempTobo);
    await AwesomeService.instance.saveContent(tempTobo);
  }

  Future<void> updateToboDone(int index) async {
    final tobo = list[index];
    tobo.done = 1;
    list.remove(tobo);
    DbManager.instance.deleteTobo(tobo);
    await AwesomeService.instance.updateDone(tobo);
  }

  @override
  void onReady() {
    super.onReady();
    getList();
  }

  Future<void> getList() async {
    final List<Tobo> listDb = await DbManager.instance.getToboList();
    list.value = listDb;
    final List<Tobo> listNet =
        await AwesomeService.instance.getTodoList() ?? [];
    list.value = listNet;
    DbManager.instance.deleteAllTobo();
    ///保存到数据库
    listNet.forEach((element) {
      DbManager.instance.saveOrUpdateTobo(element);
    });
  }
}
