import 'package:awesome_core/core.dart';
import 'package:awesome_core/ext/toast_ext.dart';
import 'package:awesome_core/net/result_data.dart';
import 'package:awesome_core/utils/print_utils.dart';

import 'http_manager.dart';

///业务并不复杂，不做api 层了，
///这里的作用就是repository
abstract class BaseRepository {
  Future<ResultData> postData(String url,
      {Map<String, dynamic>? data,
      Function(Map<String, dynamic> json)? builder,
      bool showMsg = false}) async {
    final resultData = await HttpManager.getInstance().postData(url, data: data);
    if (resultData.isSuccess()) {
      if (builder != null && resultData.data is Map<String, dynamic>) {
        resultData.data = builder(resultData.data as Map<String, dynamic>);
      }
      if (showMsg) {
        ToastExt.toast(resultData.msg);
      }
    }
    return resultData;
  }

  static List<String> listKeys = ['list', 'listData', 'data'];

  //由于返回列表是个list,就只有一个字段,就不再为整个list建立模型,取出list字段的json之后进行数据解析
  Future<ResultData> postList<T>(String url,
      {Map<String, dynamic>? data,
      Function(Map<String, dynamic> json)? builder,
      bool showMsg = false,
      String? key}) async {
    final resultData = await HttpManager.getInstance().postData(url, data: data);
    if (resultData.isSuccess()) {
      try {
        if (builder != null) {
          var datas = <T>[];
          //尝试从下面常用的字段中解析数据,可以指定key解析列表
          if (key != null && !listKeys.contains(key)) {
            listKeys.insert(0, key);
          }
          final dataJsons = resultData.data as Map<String, dynamic>;
          for (key in listKeys) {
            if (dataJsons.containsKey(key)) {
              for (final item in dataJsons[key]){
                final v = item as Map<String, dynamic>;
                datas.add(builder(v) as T);

              }
              break;
            }
          }
          resultData.data = datas;
        }
        if (showMsg) {
          ToastExt.toast(resultData.msg);
        }
      } catch (ex) {
        PrintUtil.print('error=>' + ex.toString());
        resultData.code = Code.NETWORK_JSON_EXCEPTION;
        resultData.msg = Code.NETWORK_JSON_EXCEPTION_MSG;
      }
    }
    return resultData;
  }

  Future<ResultData> get(String url,
      {Map<String, dynamic>? data,
      Function(Map<String, dynamic> json)? builder,
      bool showMsg = false}) async {
    var resultData =
        await HttpManager.getInstance().getData(url, queryParameters: data);
    if (resultData.isSuccess()) {
      try {
        if (builder != null && resultData.data is Map<String, dynamic>) {
          resultData.data = builder(resultData.data as Map<String, dynamic>);
        }
        if (showMsg) {
          ToastExt.toast(resultData.msg);
        }
      } catch (ex) {
        PrintUtil.print('error=>' + ex.toString());
        resultData.code = Code.NETWORK_JSON_EXCEPTION;
        resultData.msg = Code.NETWORK_JSON_EXCEPTION_MSG;
      }
    }
    return resultData;
  }
}
