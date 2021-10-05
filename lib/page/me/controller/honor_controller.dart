import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_update_dialog/update_dialog.dart';
import 'package:tobo/net/awesome_service.dart';
import 'package:tobo/widget/honor_widget.dart';

import '../../../r.g.dart';

class HonorController extends BaseController {
  UpdateDialog? dialog;

  @override
  void onReady() {
    super.onReady();
    queryDoneCount();
  }

  Future<void> queryDoneCount() async {
    final int count = await AwesomeService.instance.queryDoneCount() ?? 0;
    // showUpdateDialog('太棒了！', count);
    NavigatorUtil.showCommonDialog(HonorWidget(count));
  }

  void showUpdateDialog(String title, int count) {
    if (dialog != null && dialog!.isShowing()) {
      return;
    }
    dialog = UpdateDialog.showUpdate(Get.context!,
        title: title,
        updateContent: '你已经完成了[$count]个计划, \n为你自己点个赞！',
        titleTextSize: 14,
        contentTextSize: 12,
        buttonTextSize: 12,
        topImage: Image.asset(R.image.ic_honor_header().assetName),
        extraHeight: 5,
        radius: 8,
        themeColor: Get.theme.primaryColor,
        progressBackgroundColor: const Color(0x5AFFAC5D),
        isForce: true,
        updateButtonText: 'Great!',
        ignoreButtonText: '',
        enableIgnore: true, onIgnore: () {
      dialog!.dismiss();
    }, onUpdate: () {
      dialog!.dismiss();
      NavigatorUtil.pop();
    });
  }
}
