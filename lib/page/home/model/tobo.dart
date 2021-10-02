import 'package:data_plugin/bmob/table/bmob_object.dart';

class Tobo extends BmobObject {
  String content = '';
  int done = 0;

  Tobo(this.content, {this.done = 0});

  @override
  Map getParams() {
    return {}..['content'] = content;
  }
}
