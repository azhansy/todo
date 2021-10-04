import 'package:awesome_core/ext/json_parse_utils.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:tobo/common/application.dart';

class FeedbackModel extends BmobObject {
  String content = '';

  FeedbackModel(this.content);

  FeedbackModel.fromJson(Map<String, dynamic> json)
      : content = json.asString('content') {
    objectId = json.asString(Bmob.BMOB_PROPERTY_OBJECT_ID);
    createdAt = json.asString(Bmob.BMOB_PROPERTY_CREATED_AT);
    updatedAt = json.asString(Bmob.BMOB_PROPERTY_UPDATED_AT);
  }

  @override
  Map getParams() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['author'] = Application.instance.getBmobUser();
    map[Bmob.BMOB_PROPERTY_OBJECT_ID] = objectId;
    return map;
  }

  @override
  String toString() {
    return 'FeedbackModel{content: $content, objectId: $objectId}';
  }
}
