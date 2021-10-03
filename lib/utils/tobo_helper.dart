import 'package:tobo/common/database/db_manager.dart';
import 'package:tobo/page/home/model/tobo.dart';

class ToboHelper {
  static ToboHelper? _instance;
  List<Tobo> toboList = [];

  ToboHelper._() {
    init();
  }

  static ToboHelper get instance => _instance ?? ToboHelper._();

  List<Tobo> getList() => toboList;

  Future<void> init() async {
    toboList = await DbManager.instance.getToboList();
  }
}
