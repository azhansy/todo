import 'dart:ui';

import 'package:awesome_core/ext/screen_ext.dart';
import 'package:flutter/material.dart';

class Colours {
  static const Color appMain = Colors.blue;
  static const Color app_main_2 = Colors.blueAccent;
  static const Color color_ffde49 = Color(0xFFFFDE49);
  static const Color main_line_color = Color(0xFFFFE4A2);
  static const Color bg_color = Color(0xFFF6F6FA);
  static const Color gray_33 = Color(0xFF333333);
  static const Color gray_99 = Color(0xFF999999); //51
  static const Color main_text_color = Color(0xFF2D2D2D);
  static const Color text_hint_color = Color(0xFF858D9D);
  static const Color line_color = Color(0xFFA3A3A4);
  static const Color main_red = Color(0xFFE44F4C);
  static const Color msg_red_color = Color(0xFFE02020);
  static const Color FFF7E6E6 = Color(0xFFF7E6E6);
  static const Color color_f0f0f0 = Color(0xfff0f0f0);
  static const Color color_f7f7f7 = Color(0xfff7f7f7);
  static const Color price_red = Color(0xFFFB6D3A);
  static const Color gray_66 = Color(0xFF666666); //51
  static const Color hint_color = Color(0xFFD5D5D5);
  static const Color search_border_color = Color(0xFFD9D9D9);
  static const Color FFF5F5F7 = Color(0xFFF5F5F7);
  static const Color TextField_Focus_Color = Color(0xFFF5F5F5);
  static const Color blue = Color(0xFF445FF8);
  static const Color FF5C8AFF = Color(0xFF5C8AFF);
  static const Color FF666666 = Color(0xFF666666);
  static const Color FFFAFAFA = Color(0xFFFAFAFA);
  static const Color color_ededed = Color(0xffededed);
  static const Color color_2d2d2d = Color(0xff2d2d2d); //51
  static const Color color_ed7161 = Color(0xffed7161);
  static const Color color_aaaaaa = Color(0xffaaaaaa);
  static const Color color_e8e8e8 = Color(0xffe8e8f0);
  static const Color color_d8d8d8 = Color(0xffd8d8d8);
  static const Color color_5c8aff = Color(0xff5c8aff);
  static const Color color_e5e5e5 = Color(0xFFE5E5E5);
  static const Color color_f9f9fa = Color(0xFFF9F9FA);
  static const Color color_9098a7 = Color(0xFF9098a7);
  static const Color color_0e3800 = Color(0xFF0E3800);
  static const Color color_000023 = Color(0xFF000023);
  static const Color color_white = Color(0xFFFFFFFF);
  static const Color color_11151C = Color(0xFF11151C);
  static const Color color_151515 = Color(0xFF151515);
  static const Color color_242222 = Color(0xFF242222);
  static const Color color_242424 = Color(0xFF242424);
  static const Color color_282626 = Color(0xFF282626);
  static const Color color_abb2c1 = Color(0xFFabb2c1);
  static const Color color_ffbd49 = Color(0xFFffbd49);
  static const Color color_858D9D = Color(0xFF858D9D);
  static const Color color_F8F8FA = Color(0xFFF8F8FA);
  static const Color color_FFDE49 = Color(0xFFFFDE49);
  static const Color color_424040 = Color(0xFF424040);
  static const Color color_423F3D = Color(0xFF423F3D);
  static const Color color_D2D9E9 = Color(0xFFD2D9E9);
  static const Color color_FE2042 = Color(0xFFFE2042);
  static const Color color_F3F4F6 = Color(0xFFF3F4F6);
  static const Color item_selected_color = Color(0xFFF5F5F5);
  static const Color color_e8e8f0 = Color(0xffe8e8f0);
  static const Color color_f3f4f6 = Color(0xfff3f4f6);
  static const Color color_768196 = Color(0xff768196);
  static const Color color_F6F6FA = Color(0xffF6F6FA);
  static const Color color_e8ebee = Color(0xffe8ebee);
  static const Color color_f8f9fa = Color(0xfff8f9fa);
  static const Color color_fff6f6fa = Color(0xffF6F6FA);
  static const Color color_d05301 = Color(0xffd05301);
  static const Color color_0D0E15 = Color(0xff0D0E15);
  static const Color color_C4C9D4 = Color(0xffC4C9D4);
  static const Color color_ABB2C1 = Color(0xffABB2C1);
  static const Color color_858d9d = Color(0xff858D9D);
  static const Color color_36343A = Color(0xFF36343A);
  static const Color color_e2e6ea = Color(0xFFE2E6EA);
  static const Color color_c4c9d4 = Color(0xFFc4c9d4);
  static const Color color_e1e1e1 = Color(0xFFe1e1e1);
  static const Color color_333333 = Color(0xFF333333);
  static const Color color_666666 = Color(0xFF666666);
  static const Color color_02081E = Color(0xFF02081E);
  static const Color color_f2f2f4 = Color(0xFFf2f2f4);
  static const Color color_9A9CA5 = Color(0xFF9A9CA5);
  static const Color color_f7f7fa = Color(0xfff7f7fa);
  static const Color color_E3E8F2 = Color(0xffE3E8F2);
  static const Color color_e5e6e8 = Color(0xFFe5e6e8);
  static const Color color_1649fb = Color(0xFF1649fb);
  static const Color color_676B78 = Color(0xFF676B78);
  static const Color color_3f3f3f = Color(0xFF3f3f3f);
  static const Color color_fc3162 = Color(0xFFFC3162);
  static const Color color_f4f4f8 = Color(0xFFf4f4f8);
  static const Color color_878E9B = Color(0xFF878E9B);
  static const Color color_888888 = Color(0xFFF888888);
  static const Color color_e8edff = Color(0xFFe8edff);
  static const Color color_66000000 = Color(0xFF66000000);

  static const app_decoration = BoxDecoration(gradient: mainLinearGradient);
  static const LinearGradient mainLinearGradient =
      LinearGradient(colors: [app_main_2, appMain]);

  static const LinearGradient carDetailGradient = LinearGradient(
      colors: [color_f7f7f7, color_242424],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const LinearGradient bankCardGradient =
      LinearGradient(colors: [Color(0xFF93A4C2), Color(0xFF6B7891)]);

  static BorderRadius mainBorderRadius24 =
      BorderRadius.all(Radius.circular(24.w));

  static const Color borderColor = Color(0xFFE8E8F0);
}

Map<String, Color> themeColorMap = {
  'default': Colours.appMain,
  'gray': Colours.gray_33,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.deepPurple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.deepOrange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};
