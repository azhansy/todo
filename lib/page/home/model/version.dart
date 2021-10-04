import 'package:awesome_core/core.dart';
import 'package:awesome_core/ext/json_parse_utils.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';

class Version extends BmobObject {
  int versionCode = 1;
  String androidLink = '';
  String iosLink = '';
  String title = '';
  String content = '';

  Version(this.versionCode, this.title, this.content,
      {this.androidLink = '', this.iosLink = ''});

  String get link => GetPlatform.isAndroid ? androidLink : iosLink;

  Version.fromJson(Map<String, dynamic> json)
      : versionCode = json.asInt('versionCode'),
        androidLink = json.asString('androidLink'),
        title = json.asString('title'),
        content = json.asString('content'),
        iosLink = json.asString('iosLink') {
    objectId = json.asString(Bmob.BMOB_PROPERTY_OBJECT_ID);
    createdAt = json.asString(Bmob.BMOB_PROPERTY_CREATED_AT);
    updatedAt = json.asString(Bmob.BMOB_PROPERTY_UPDATED_AT);
  }

  @override
  Map getParams() {
    final map = <String, dynamic>{};
    map['versionCode'] = versionCode;
    map['androidLink'] = androidLink;
    map['iosLink'] = iosLink;
    map['title'] = title;
    map['content'] = content;
    map[Bmob.BMOB_PROPERTY_OBJECT_ID] = objectId;
    return map;
  }
}
