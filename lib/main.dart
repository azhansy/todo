import 'dart:async';

import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tobo/app_pages.dart';

import 'common/database/db_manager.dart';
import 'res/colors.dart';
import 'res/translation_service.dart';
import 'utils/language_util.dart';

void main() {
  Global.init(
    () async {
      await initBmob();
      await DbManager.instance.init();
      runApp(const MyApp());
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
