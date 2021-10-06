import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/res/colors.dart';
import 'package:tobo/widget/todo_scaffold.dart';

///
/// @author dashu
/// @date 10/2/21
/// describe:
///
class ThemePage extends StatefulWidget {
  static const String routeName = '/ThemePage';

  const ThemePage({Key? key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return TodoScaffold(
      title: 'Theme Color',
      body: GridView.count(
        crossAxisCount: 7,
        mainAxisSpacing: 5.0.w,
        crossAxisSpacing: 5.0.w,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        children: themeColorMap.keys.map((String key) {
          final Color value = themeColorMap[key]!;
          return InkWell(
            onTap: () {
              SpUtil.putInt(BaseConfig.KEY_THEME, value.value);
              Get.changeTheme(ThemeUtil.copyTheme(value));
            },
            child: Container(
              color: value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
