import 'package:flutter/material.dart';

///
/// @author dashu
/// @date 10/1/21
/// describe:
///
class LoginPage extends StatelessWidget {
  static const String routeName = '/login/LoginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('login')),
      ),
    );
  }
}
