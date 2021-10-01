import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';


class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('zh', 'CN');

  @override
  Map<String, Map<String, String>> get keys => localizedSimpleValues;
}
