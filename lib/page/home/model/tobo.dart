import 'package:data_plugin/bmob/table/bmob_object.dart';

class Tobo extends BmobObject {
  String content = '';

  @override
  Map getParams() {
    return {}..['content'] = content;
  }
}
