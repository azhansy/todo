import 'package:flutter/material.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class MainPage extends StatefulWidget {
  static const String routeName = '/MainPage';

  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: const Text('home')),
      ),
    );
  }
}
