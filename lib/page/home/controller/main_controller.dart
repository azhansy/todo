import 'package:awesome_core/core.dart';
import 'package:tobo/page/home/model/tobo.dart';

class MainController extends BaseController {
  RxList<Tobo> list = <Tobo>[].obs;

  void addTobo(Tobo tobo) {
    list.add(tobo);
  }
}
