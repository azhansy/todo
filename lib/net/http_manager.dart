import 'package:awesome_core/core.dart';
import 'package:awesome_core/net/base_httpmanager.dart';
import 'package:data_plugin/bmob/bmob_query.dart';

import 'api/apis.dart';

class HttpManager extends BaseHttpManager {
  HttpManager._();

  static late HttpManager? _instance;

  static HttpManager getInstance() {
    return _instance ??= HttpManager._();
  }

  @override
  String buildBaseUrl() => Apis.resolveHost();

}
