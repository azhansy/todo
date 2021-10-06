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
    final size = (Get.width - 7 * 10) / 7;
    return TodoScaffold(
      title: 'Theme Color',
      body: Column(
        children: [
          20.sizedBoxH,
          Wrap(
            children: themeColorMap.keys.map((String key) {
              final Color value = themeColorMap[key]!;
              return InkWell(
                onTap: () {
                  SpUtil.putInt(BaseConfig.KEY_THEME, value.value);
                  Get.changeTheme(ThemeUtil.copyTheme(value));
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  width: size,
                  height: size,
                  color: value,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
