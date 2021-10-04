import 'dart:math';

import 'package:awesome_core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_update_dialog/flutter_update_dialog.dart';
import 'package:tobo/common/database/db_manager.dart';
import 'package:tobo/net/index.dart';
import 'package:tobo/page/home/model/tobo.dart';
import 'package:tobo/page/home/model/version.dart';

class MainController extends BaseController {
  RxList<Tobo> list = <Tobo>[].obs;
  UpdateDialog? dialog;

  Future<void> addTobo(String content) async {
    final tempTobo = Tobo(content);
    //本地数据库的id
    tempTobo.setObjectId(Md5Util.generateMd5(
        DateTime.now().toString() + Random().nextInt(10000).toString()));
    list.add(tempTobo);
    DbManager.instance.saveOrUpdateTobo(tempTobo);
    final Tobo? tobo = await AwesomeService.instance.saveContent(tempTobo);
    if (null != tobo) {
      DbManager.instance.deleteTobo(tempTobo);
      DbManager.instance.saveOrUpdateTobo(tobo);
      list.remove(tempTobo);
      list.add(tobo);
    }
  }

  Future<void> updateToboDone(int index) async {
    final tobo = list[index];
    tobo.done = 1;
    list.remove(tobo);
    await DbManager.instance.deleteTobo(tobo);
    //如果已经同步到服务器就删除；
    if (!tobo.isNotUpload) {
      await AwesomeService.instance.updateDone(tobo);
    }
  }

  Future<void> updateToboContent(Tobo tobo) async {
    final index =
        list.indexWhere((element) => element.objectId == tobo.objectId);
    debugPrint('dashu, update index=$index ');

    if (index > -1) {
      list.removeAt(index);
      list.insert(index, tobo);
      await DbManager.instance.saveOrUpdateTobo(tobo);
      //如果已经同步到服务器就继续更新到服务器；
      if (!tobo.isNotUpload) {
        await AwesomeService.instance.updateDone(tobo);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    getList();
    checkVersion();
  }

  Future<void> getList() async {
    final List<Tobo> listDb = await DbManager.instance.getToboList();
    list.value = listDb;
    final List<Tobo> listNet =
        await AwesomeService.instance.getTodoList() ?? [];
    if (listNet.isNotEmpty) {
      list.value = listNet;
    }

    ///获取未备份的本地数据
    listDb.removeWhere((element) => !element.isNotUpload);

    ///剩余未同步的
    final temp = listDb;

    /// 清除本地数据库
    DbManager.instance.deleteAllTobo();

    ///保存到数据库
    listNet.forEach((element) {
      DbManager.instance.saveOrUpdateTobo(element);
    });
    debugPrint('dashu, temp sieze=${temp.length}');

    ///本地的同步到服务器
    if (temp.isNotEmpty) {
      final tempListNet = <Tobo>[];
      await Future.forEach<Tobo>(temp, (element) async {
        debugPrint('dashu, temp tobo=${element.getParams()}');
        final tobo = await AwesomeService.instance.saveContent(element);
        if (null != tobo) {
          debugPrint('dashu, temp add net =${element.getParams()}');
          DbManager.instance.saveOrUpdateTobo(tobo);
          tempListNet.add(tobo);
        }
      });
      debugPrint('dashu, temp =====finish ');
      list.addAll(tempListNet);
    }
  }

  Future<void> checkVersion() async {
    final Version? version = await AwesomeService.instance.checkVersion();
    final code = Config.VERSION_CODE.substring(
        Config.VERSION_CODE.indexOf('(') + 1, Config.VERSION_CODE.indexOf(')'));
    debugPrint(
        'version.versionCode=${version?.versionCode} , code.secureInt=${code.secureInt}');
    if (null != version && version.versionCode > code.secureInt) {
      showUpdateDialog(version.title, version.content, version.link);
    }
  }

  void showUpdateDialog(String title, String content, String link) {
    if (dialog != null && dialog!.isShowing()) {
      return;
    }
    dialog = UpdateDialog.showUpdate(
      Get.context!,
      title: title,
      updateContent: content.replaceAll('\\n', '\n'),
      themeColor: Get.theme.primaryColor,
      onUpdate: () => onUpdate(link),
    );
  }

  void onUpdate(String link) {
    link.openBrowser();
  }
}
