import 'package:awesome_core/core.dart';
import 'package:todo/res/index.dart';

///设置语言工具
class LanguageUtil extends BaseLanguageUtil {
  static LanguageUtil? _instance;

  LanguageUtil._();

  static LanguageUtil get instance => _instance ?? LanguageUtil._();

  @override
  List<Language> getLanguages() => [
        Language(Ids.languageZH, 'zh', 'CN'),
        Language(Ids.languageEN, 'en', 'US'),
      ];
}
