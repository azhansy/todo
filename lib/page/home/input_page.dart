import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';

import '../../r.g.dart';

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

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () => onSave(),
        )
      ],
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
      'Please add your todo content'.toast();
      return;
    }

    NavigatorUtil.pop(result: content);
  }
}
