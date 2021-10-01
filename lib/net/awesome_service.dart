import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:tobo/common/application.dart';
import 'package:tobo/res/index.dart';

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
    try {
      final user = await bmobUser.login();
      Application.instance.setAccount(user);
      Get.dismiss();
      return true;
    } catch (e) {
      Get.dismiss();
      Ids.logoutFail.str().toast();
      return false;
    }
  }
}
