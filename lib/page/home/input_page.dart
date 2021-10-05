import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';

import 'package:tobo/widget/todo_scaffold.dart';

import 'controller/main_controller.dart';
import 'model/tobo.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class InputPage extends StatefulWidget {
  static const String routeName = '/InputPage';

  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final controller = TextEditingController();
  Tobo? _tobo;

  @override
  void initState() {
    super.initState();
    _tobo = Get.arguments;
    if (null != _tobo) {
      controller.text = _tobo!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TodoScaffold(
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () => onSave(),
        )
      ],
      title: null == _tobo ? 'Add todo' : 'Edit todo',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.note_add),
            labelText: 'Your todo',
            helperText: 'Write your simple todo',
          ),
          controller: controller,
          autofocus: true,
          onSubmitted: (s) => onSave(),
        ),
      ),
    );
  }

  void onSave() {
    final content = controller.text.trim();
    if (content.isEmpty) {
      'Please input your todo content'.toast();
      return;
    }

    if (null != _tobo) {
      final MainController _mainController = Get.put(MainController());
      _tobo!.content = content;
      _mainController.updateToboContent(_tobo!);
      'Edit success'.toast();
      NavigatorUtil.pop();
      return;
    }

    NavigatorUtil.pop(result: content);
  }
}
