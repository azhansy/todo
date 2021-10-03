import 'package:awesome_core/core.dart';
import 'package:tobo/net/index.dart';
import 'package:tobo/page/home/model/tobo.dart';

class MainController extends BaseController {
  RxList<Tobo> list = <Tobo>[].obs;

  Future<void> addTobo(String content) async {
    final Tobo? tobo = await AwesomeService.instance.saveContent(content);
    if (tobo != null) {
      list.add(tobo);
    }
  }

  Future<void> updateToboDone(int index) async {
    final tobo = list[index];
    tobo.done = 1;
    final Tobo? toboUpdate = await AwesomeService.instance.updateDone(tobo);
    if (toboUpdate != null) {
      list.remove(tobo);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getList();
  }

  Future<void> getList() async {
    final List<Tobo> list1 = await AwesomeService.instance.getTodoList() ?? [];
    list.value = list1;
  }
}
