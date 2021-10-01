import 'dart:async';

import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tobo/app_pages.dart';

import 'net/api/apis.dart';
import 'res/colors.dart';
import 'res/translation_service.dart';
import 'utils/language_util.dart';

void main() {
  Global.init(
    () async {
      await initBmob();
      // Apis.init();
      //ios的正式包、如果域名是测试环境可以切
      final firstShow = (GetPlatform.isIOS &&
              (Apis.resolveHost() == Apis.HOST_TEST ||
                  Apis.resolveHost() == Apis.HOST_RC)) ||
          GetPlatform.isAndroid;
      if (BaseConfig.showMonitorError) {
        await runZonedGuarded(() async {
          WidgetsFlutterBinding.ensureInitialized();
          runApp(UmeUtil.initUme(const MyApp(), firstShow));
        }, (error, stack) async {});
      } else {
        runApp(UmeUtil.initUme(const MyApp(), firstShow));
      }
    },
  );
}

Future<void> initBmob() async {
  final supportEnv = !GetPlatform.isDesktop || GetPlatform.isWeb;
  if (supportEnv) {
    await dotenv.load();
  }
  debugPrint('初始化bmob=$supportEnv');
  Bmob.init('https://api2.bmob.cn', supportEnv ? dotenv.env['app_id'] : '',
      supportEnv ? dotenv.env['api_key'] : '');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return App(
      defaultThemeColor: Colours.appMain,
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      locale: LanguageUtil.instance.initLanguage().toLocale(),
      translations: TranslationService(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
