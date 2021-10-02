import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:tobo/common/application.dart';

import 'base_repository.dart';

///接口对接
class AwesomeService extends BaseRepository {
  static AwesomeService? _instance;

  AwesomeService._();

  static AwesomeService get instance => _instance ??= AwesomeService._();

  /// 登录
  /*Future<BmobUser>*/
  Future<bool> login(String account, String psw) async {
    Get.loading();
    final bmobUser = BmobUser();
    bmobUser.username = account;
    bmobUser.password = psw;
    return _doing(() async {
      final user = await bmobUser.login();
      Application.instance.setAccount(user);
    });
  }

  Future<bool> register(String account, String psw) async {
    Get.loading();
    final bmobUser = BmobUser();
    bmobUser.username = account;
    bmobUser.password = psw;
    return _doing(() async {
      final BmobRegistered user = await bmobUser.register();
      bmobUser.sessionToken = user.sessionToken;
      bmobUser.createdAt = user.createdAt;
      bmobUser.objectId = user.objectId;
      Application.instance.setAccount(bmobUser);
    });
  }

  Future<bool> _doing(Function function) async {
    try {
      await function();
      Get.dismiss();
      return true;
    } catch (e) {
      Get.dismiss();
      BmobError.convert(e)?.error?.toast();
      return false;
    }
  }
}
