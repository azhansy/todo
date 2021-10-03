import 'package:awesome_core/core.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:flutter/material.dart';
import 'package:tobo/animation/FadeAnimation.dart';
import 'package:tobo/net/index.dart';
import 'package:tobo/page/home/main_page.dart';
import 'package:tobo/page/login/register_page.dart';
import 'package:tobo/res/colors.dart';

import '../../r.g.dart';

///
/// @author dashu
/// @date 10/1/21
/// describe:
///
class LoginPage extends StatefulWidget {
  static const String routeName = '/login/LoginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final FocusNode pswFocusNode = FocusNode();

  String account = '';

  String psw = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: R.image.background(), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image:
                                    DecorationImage(image: R.image.light_1())),
                          )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image:
                                    DecorationImage(image: R.image.light_2())),
                          )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(image: R.image.clock())),
                          )),
                    ),
                    Positioned(
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        1.8,
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, 0.2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]!))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      icon: const Icon(Icons.person),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      //校验密码
                                    ),
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(pswFocusNode);
                                    },
                                    validator: (v) {
                                      return (v?.trim().length ?? 0) > 4
                                          ? null
                                          : 'Please enter more than 4 characters';
                                    },
                                    onSaved: (value) => account = value ?? '',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: const Icon(Icons.lock),
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                    validator: (v) {
                                      return (v?.trim().length ?? 0) > 4
                                          ? null
                                          : 'Please enter more than 4 characters';
                                    },
                                    onSaved: (value) => psw = value ?? '',
                                    focusNode: pswFocusNode,
                                    onEditingComplete: () {
                                      _clickButton();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        GestureDetector(
                          onTap: () {
                            _clickButton();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: Colours.mainLinearGradient,
                            ),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                    50.sizedBoxH,
                    FadeAnimation(
                      1.5,
                      TextButton(
                        onPressed: () {
                          NavigatorUtil.pushName(RegisterPage.routeName);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _clickButton() async {
    final FormState? currentState = _formKey.currentState as FormState?;
    if (currentState?.validate() ?? false) {
      currentState!.save();
      //验证通过提交数据
      final BmobUser? user = await AwesomeService.instance.login(account, psw);
      if (user != null) {
        NavigatorUtil.offAllNamed(MainPage.routeName);
      }
    }
  }
}
