import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/register_form.dart';

class RegisterClientPage extends StatefulWidget {
  static const routeName = 'registerClient';
  _RegisterClientPage createState() => _RegisterClientPage();
}

class _RegisterClientPage extends State<RegisterClientPage> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    const String textRegister = "Crear nueva cuenta";
    final TextStyle textLoginStyle =
        TextStyle(fontSize: responsive.dp(2), color: Colors.white);

    ButtonStyle goBackButtonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(10),
      shape: const CircleBorder(),
      backgroundColor: Colors.black45,
      minimumSize: Size(
        responsive.wp(5),
        responsive.hp(5),
      ),
      maximumSize: Size(
        responsive.wp(30),
        responsive.wp(30),
      ),
    );

    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: responsive.getHeight(),
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
                    height: responsive.dp(2),
                  ),
                  Row(
                    children: <Widget>[
                      Positioned(
                        left: 15,
                        top: 15,
                        child: SafeArea(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: goBackButtonStyle,
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: responsive.dp(15),
                      ),
                      Text(
                        textRegister,
                        textAlign: TextAlign.center,
                        style: textLoginStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.dp(5),
                  ),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
