import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'loginPage';
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String textLogin = "Inicio de sesion\nIngrese su cuenta";

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    TextStyle textLoginStyle =
        TextStyle(fontSize: responsive.dp(2), color: Colors.white);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: responsive.getHeight(),
            width: responsive.getWidth(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(237, 241, 214, 1.0),
                Color.fromRGBO(157, 192, 139, 1.0),
                Color.fromRGBO(96, 153, 102, 1.0),
                Color.fromRGBO(64, 81, 59, 1.0),
              ], begin: Alignment.topRight, end: Alignment.bottomCenter),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: responsive.dp(5),
                  ),
                  Text(
                    textLogin,
                    textAlign: TextAlign.center,
                    style: textLoginStyle,
                  ),
                  SizedBox(
                    height: responsive.dp(5),
                  ),
                  LoginForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
