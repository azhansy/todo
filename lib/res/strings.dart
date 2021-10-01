import 'string_cn.dart';
import 'string_en.dart';

///获取资源
///IntlUtil.getString(context, Ids.appName)
class Ids {
  static const String appName = 'app_name';
  static const String company = 'company';
  static const String save = 'save';
  static const String more = 'more';
  static const String confirm = 'confirm';
  static const String cancel = 'Cancel';
  static const String common = 'common';
  static const String loading = 'loading';
  static const String areaCommon = 'area_common';
  static const String tempNoListData = 'tempNoListData';
  static const String errorNetWork = 'errorNetWork';
  static const String reload = 'reload';

  static const String languageZH = 'language_zh';
  static const String languageSimpleZH = 'languageSimpleZH';
  static const String languageKM = 'language_km';
  static const String languageEN = 'language_en';
  static const String language = 'language';
  static const String notification = 'notification';
  static const String privacy = 'privacy';
  static const String changeTheme = 'change_theme';
  static const String chooseLanguage = 'chooseLanguage';
  static const String skip = 'skip';
  static const String agree = 'agree';
  static const String disagree = 'disagree';
  static const String load_more = 'load_more';
  static const String loading_more = 'loading_more';
  static const String load_more_fail = 'load_more_fail';
  static const String load_more_no_data = 'load_more_no_data';

  static const String userLogin = 'user_login';
  static const String login = 'login_text';
  static const String userName = 'user_name';
  static const String password = 'password';
  static const String loginPassword = 'login_password';
  static const String loginPasswordTips = 'login_password_tips';
  static const String userNameOrEmail = 'user_name_or_email';
  static const String userNameCantNot = 'user_name_cant_not';
  static const String settings = 'settings';
  static const String dartModel = 'dart_model';
  static const String lightModel = 'light_model';
  static const String logout = 'logout';
  static const String logoutFail = 'logout_fail';
  static const String exitConfirm = 'exit_confirm';
  static const String optSuccess = 'opt_success';
  static const String planSettings = 'plan_settings';
  static const String industryNews = 'industry_news';
  static const String friendsLink = 'friend_link';

}

///不需要翻译的文案
const Map<String, String> noTranslate = {
  Ids.languageZH: '简体中文',
  Ids.languageKM: 'ជនជាតិខ្មែរ។',
  Ids.languageEN: 'English',
  Ids.languageSimpleZH: '中文',
};

const Map<String, Map<String, String>> localizedSimpleValues = {
  //简体中文
  'zh_CN': languageChinese,
  // 'en': languageChinese,
  // 'km': languageChinese,
  //英文
  'en_US': languageEnglish,
  // 'km': languageKM,
};
