import 'package:awesome_core/base/base_api_core.dart';

///业务的错误code值，
class ApiCode with BaseApiCode{
  ///账号状态不可用，如有疑问，请联系客服
  static const ACCOUNT_ERROR = 4020;
  ///需要登录
  static const NEED_LOGIN = 4010;
  ///设备未授权
  static const DEVICE_NO_AUTHORIZATION = 1007;
  ///版本检查为0，强制更新为-10005，1.普通更新 2.强制更新
  static const VERSION_UPDATE = -10005;

  static const NETWORK_JSON_EXCEPTION_MSG = '似乎遇到一点点小问题，非常抱歉给您带来不便！';

  static const NETWORK_TIMEOUT = -9999999;


}
