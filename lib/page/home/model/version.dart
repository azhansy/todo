import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';

class Version extends BmobObject {
  int versionId = 1;
  String androidLink = '';
  String iosLink = '';

  Version(this.versionId, {this.androidLink = '', this.iosLink = ''});

  @override
  Map getParams() {
    final map = <String, dynamic>{};
    map['versionId'] = versionId;
    map['androidLink'] = androidLink;
    map['iosLink'] = iosLink;
    map[Bmob.BMOB_PROPERTY_OBJECT_ID] = objectId;
    return map;
  }
}
