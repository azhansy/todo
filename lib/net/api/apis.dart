import 'package:awesome_core/base/base_config.dart';
import 'package:awesome_core/lib/index.dart';

class Apis {
  static const String HOST_TG_LOG =
      'https://api.telegram.org/bot1448356880:AAHzrG_YeA05d9UNYjZeP1aBNuYQnLf0bRk/';

  static const String LOGIN = '/?ct=user&ac=login';

  static const String HOST_RC = '';

  ///灰度
  static const String HOST_TEST = '';

  ///线上环境
  static const String HOST = '';

  static String _host = HOST;

  static void init() {
    if (BaseConfig.DEBUG) {
      _host = SpUtil.getString(BaseConfig.HOST, defValue: null) ?? HOST_RC;
      IS_ENCRYPT =
          SpUtil.getBool(BaseConfig.IS_ENCRYPT, defValue: _host != HOST_RC)!;
    } else {
      _host = HOST;
    }
  }

  static void switchHost(String newHost) {
    _host = newHost;
    SpUtil.putString(BaseConfig.HOST, _host);
  }

  static String resolveHost() {
    return _host;
  }

  static int getHostTest() {
    if (resolveHost() == HOST_RC) {
      return 2;
    } else if (_host == HOST_TEST) {
      return 1;
    }
    return 0;
  }

  static bool IS_ENCRYPT = true;

  static Future switchIsEncrypt(bool isEncrypt) async {
    IS_ENCRYPT = isEncrypt;
    await SpUtil.putBool(BaseConfig.IS_ENCRYPT, isEncrypt);
    return null;
  }
}
