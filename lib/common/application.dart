import 'dart:convert';

import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database/db_manager.dart';

class Application {
  static Application get instance => _instance ??= Application._();
  static Application? _instance;

  Application._();

  //用来刷新数
  BmobUser? _account;

  //用来静态判断
  static BmobUser? staticBmobUser;

  static String utma = '';

  void init() {
    utma = BaseConfig.IMEI;
    // 初始化
    final String user = SpUtil.getString('user') ?? '';
    if (user.isNotEmpty) {
      final map = json.decode(user);
      _account = BmobUser.fromJson(map);
      staticBmobUser = _account;
    } else {
      _account = null;
    }
  }

  Future<void> saveBmobUser(BmobUser account, {bool save = true}) async {
    _account = account;
    staticBmobUser = account;
    if (save && null != _account) {
      final result = await _account!.save();
      debugPrint('是否保存成功=$result,${_account.toString()}');
    }
    // notifyListeners();
  }

  BmobUser? getBmobUser() {
    return _account;
  }

  void setAccount(BmobUser bmobUser) {
    _account = bmobUser;
    staticBmobUser = bmobUser;
  }

  String? getToken() {
    return '';
  }

  String? getUid() {
    return _account?.objectId;
  }

  // ignore: avoid_void_async
  void clearAuthorization() async {
    if (null != _account) {
      // _account!.delete();
      SpUtil.putString('user', '');
      await DbManager.instance.deleteAllTobo();
      _account = null;
      staticBmobUser = null;
      // notifyListeners();
    }
  }

  void logout({BuildContext? context}) {
    context ??= Get.context;
    if (context != null) {
      clearAuthorization();
    }
  }

  bool get isLogin => _account != null;
}
