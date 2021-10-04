import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:tobo/common/application.dart';
import 'package:tobo/page/home/model/tobo.dart';
import 'package:tobo/page/home/model/version.dart';

import 'base_repository.dart';

///接口对接
class AwesomeService extends BaseRepository {
  static AwesomeService? _instance;

  AwesomeService._();

  static AwesomeService get instance => _instance ??= AwesomeService._();

  /// 登录
  /*Future<BmobUser>*/
  Future<BmobUser?> login(String account, String psw) async {
    Get.loading();
    final bmobUser = BmobUser();
    bmobUser.username = account;
    bmobUser.password = psw;
    return _doing<BmobUser>(() async {
      final user = await bmobUser.login();
      Application.instance.setAccount(user);
      return user;
    });
  }

  Future<BmobUser?> register(String account, String psw) async {
    Get.loading();
    final bmobUser = BmobUser();
    bmobUser.username = account;
    bmobUser.password = psw;
    return _doing<BmobUser>(() async {
      final BmobRegistered user = await bmobUser.register();
      bmobUser.sessionToken = user.sessionToken;
      bmobUser.createdAt = user.createdAt;
      bmobUser.objectId = user.objectId;
      Application.instance.setAccount(bmobUser);
      return bmobUser;
    });
  }

  Future<Tobo?> saveContent(Tobo tobo) async {
    return _doing<Tobo>(() async {
      final BmobSaved saved = await tobo.save();
      return tobo;
    });
  }

  ///done 0 未出来、1处理
  Future<Tobo?> updateDone(Tobo tobo) async {
    print('dashu, tobo=${tobo.getParams()}');
    return _doing<Tobo>(() async {
      await tobo.update();
      return tobo;
    });
  }

  Future<List<Tobo>?> getTodoList({int page = 0}) async {
    // Get.loading();
    return _doing<List<Tobo>>(
      () async {
        final BmobQuery<Tobo> query = BmobQuery();
        query.addWhereEqualTo('done', 0);
        query.addWhereEqualTo('author', Application.instance.getBmobUser());
        //设置返回条数
        query.setLimit(10);
        final List<dynamic>? data = await query.queryObjects();
        final List<Tobo>? tobos = data?.map((i) => Tobo.fromJson(i)).toList();
        return tobos;
      },
    );
  }

  Future<Version?> checkVersion() async {
    // Get.loading();
    return _doing<Version>(
      () async {
        final BmobQuery<Version> query = BmobQuery();
        //设置返回条数
        query.setLimit(1);
        final List<dynamic>? data = await query.queryObjects();
        final List<Version>? tobos =
            data?.map((i) => Version.fromJson(i)).toList();
        return tobos.unwrap().isNotEmpty ? tobos![0] : null;
      },
    );
  }

  Future<T?> _doing<T>(Function function) async {
    try {
      final T result = await function();
      Get.dismiss();
      return result;
    } catch (e) {
      Get.dismiss();
      BmobError.convert(e)?.error?.toast();
      return null;
    }
  }
}
