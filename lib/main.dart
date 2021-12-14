import 'dart:async';
import 'dart:io';

import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tobo/app_pages.dart';

import 'common/application.dart';
import 'common/database/db_manager.dart';
import 'res/colors.dart';
import 'res/translation_service.dart';
import 'utils/language_util.dart';

void main() {
  Global.init(
    () async {
      await initBmob();
      await DbManager.instance.init();
      Application.instance.init();
      runApp(const MyApp());
    },
    h: 375.0,
    w: 812.0,
  );
}

Future<void> initBmob() async {
  final supportEnv = GetPlatform.isMobile;
  if (supportEnv) {
    await dotenv.load();
  }
  debugPrint('初始化bmob=$supportEnv');
  Bmob.init(
      'https://api2.bmob.cn',
      supportEnv ? dotenv.env['app_id'] : '90ec4fe40d2610e59fb7dc987e3496c3',
      supportEnv ? dotenv.env['api_key'] : 'd58c130b9fb0ad3217d8448ea8cf02e2');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Color _themeColor;

  @override
  void initState() {
    super.initState();
    initListener();
  }

  void initListener() {
    final colorValue = SpUtil.getInt(BaseConfig.KEY_THEME)!;
    if (colorValue != 0) {
      _themeColor = Color(colorValue);
    } else {
      _themeColor = Colours.appMain;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: !kReleaseMode,
      logWriterCallback: Logger.write,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
      locale: LanguageUtil.instance.initLanguage().toLocale(),
      theme: ThemeUtil.copyTheme(_themeColor),
      translations: TranslationService(),
      builder: (context, child) {
        return OKToast(
          backgroundColor: Colors.black54,
          textPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          radius: 20.0,
          position: ToastPosition.bottom,
          child: GestureDetector(
            onTap: () {
              hideKeyboard(context);
            },
            child: child,
          ),
        );
      },
    );
  }

  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
