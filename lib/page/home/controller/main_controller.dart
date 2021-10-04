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
    tempTobo.setObjectId(Md5Util.generateMd5(
        DateTime.now().toString() + Random().nextInt(10000).toString()));
    list.add(tempTobo);
    DbManager.instance.saveOrUpdateTobo(tempTobo);
    await AwesomeService.instance.saveContent(tempTobo);
  }

  Future<void> updateToboDone(int index) async {
    final tobo = list[index];
    tobo.done = 1;
    list.remove(tobo);
    await DbManager.instance.deleteTobo(tobo);
    await AwesomeService.instance.updateDone(tobo);
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

    ///获取未备份的本地数据
    listDb.removeWhere((element) {
      bool same = false;
      for (final elementNet in listNet) {
        same = elementNet.objectId == element.objectId;
        if (same) {
          break;
        }
      }
      return false;
    });
    final temp = listDb;
    listNet.addAll(temp);
    list.value = listNet;

    /// 清除本地数据库
    DbManager.instance.deleteAllTobo();

    ///保存到数据库
    listNet.forEach((element) {
      DbManager.instance.saveOrUpdateTobo(element);
    });

    ///本地的同步到服务器
    temp.forEach((element) {
      AwesomeService.instance.updateDone(element);
    });
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
