import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';

///
/// @author dashu
/// @date 10/4/21
/// describe:
///
class ContainerBody extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ContainerBody({required this.child, this.padding, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        color: Get.theme.primaryColor.withOpacity(0.1),
        constraints: const BoxConstraints(
          minHeight: double.infinity,
          minWidth: double.infinity,
        ),
        child: child,
        padding: padding,
      ),
    );
  }
}
