import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/net/awesome_service.dart';

import 'package:tobo/widget/todo_scaffold.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class FeedbackPage extends StatefulWidget {
  static const String routeName = '/FeedbackPage';

  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TodoScaffold(
      title: 'Feedback',
      actions: [
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () => onSave(),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            labelText: 'Your feedback',
            helperText: 'Write your feedback',
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Get.theme.primaryColor,
            )),
          ),
          minLines: 3,
          maxLines: 8,
          maxLength: 100,
          controller: controller,
          autofocus: true,
          onSubmitted: (s) => onSave(),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    final content = controller.text.trim();
    if (content.isEmpty) {
      'Please add your feedback content'.toast();
      return;
    }
    if (content.length <= 5) {
      'Your feedback content length must more than 5'.toast();
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());

    final result = await AwesomeService.instance.feedbackContent(content);
    if (null != result) {
      'We have received your feedback, thank you.'.toast();
      NavigatorUtil.pop();
    }
  }
}
