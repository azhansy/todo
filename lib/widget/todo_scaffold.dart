import 'package:flutter/material.dart';
import 'package:tobo/res/colors.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class TodoScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final bool? resizeToAvoidBottomInset;

  const TodoScaffold({
    required this.body,
    this.actions,
    this.title,
    this.resizeToAvoidBottomInset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
        actions: actions,
      ),
      backgroundColor: Colours.appBg,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      body: body,
    );
  }
}
