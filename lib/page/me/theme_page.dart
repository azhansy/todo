import 'package:awesome_core/core.dart';
import 'package:flutter/material.dart';
import 'package:tobo/res/colors.dart';
import 'package:tobo/widget/container_body.dart';

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
    return ScaffoldWidget(
      title: 'Theme Color',
      body: ContainerBody(
        padding: 20.marginTop(),
        child: Column(
          children: [
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
                    width: 36.0,
                    height: 36.0,
                    color: value,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
