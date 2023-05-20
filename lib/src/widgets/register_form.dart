import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String labelInputFullName = "Nombre completo";
  String labelInputLicenseNumber = "Numero de licencia";
  String labelInputBornDate = "Fecha de nacimiento";
  String labelInputPhoneNumber = "Numero de telefono";
  String labelInputPassword = "Contraseña";
  String labelInputConfirmPassword = "Confirmar Contraseña";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    TextStyle forgotPasswordStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: responsive.hp(2.1));

    TextStyle loginButton = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: responsive.hp(2.4));

    BoxDecoration decorationPassword = const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black38)));

    ButtonStyle styleLoginButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.teal.shade900,
      fixedSize: Size(
        responsive.wp(27),
        responsive.hp(7.5),
      ),
    );

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.wp(65),
          minWidth: responsive.wp(50),
        ),
        child: Column(
          children: <Widget>[
            InputText(
              keyboardType: TextInputType.name,
              label: labelInputFullName,
              fontSize: responsive.hp(2.5),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            InputText(
              keyboardType: TextInputType.text,
              label: labelInputLicenseNumber,
              fontSize: responsive.hp(2.5),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            InputText(
              keyboardType: TextInputType.datetime,
              label: labelInputBornDate,
              fontSize: responsive.hp(2.5),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            InputText(
              keyboardType: TextInputType.number,
              label: labelInputPhoneNumber,
              fontSize: responsive.hp(2.5),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            Container(
              decoration: decorationPassword,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InputText(
                        label: labelInputPassword,
                        obscureText: obscurePassword,
                        borderEnabled: false,
                        fontSize: responsive.hp(2.5)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (obscurePassword) {
                          obscurePassword = false;
                        } else {
                          obscurePassword = true;
                        }
                      });
                    },
                    child: Text(
                      "Mostrar contraseña",
                      style: forgotPasswordStyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            Container(
              decoration: decorationPassword,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InputText(
                        label: labelInputConfirmPassword,
                        obscureText: obscureConfirmPassword,
                        borderEnabled: false,
                        fontSize: responsive.hp(2.5)),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (obscureConfirmPassword) {
                          obscureConfirmPassword = false;
                        } else {
                          obscureConfirmPassword = true;
                        }
                      });
                    },
                    child: Text(
                      "Mostrar contraseña",
                      style: forgotPasswordStyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'paginaPrueba');
              },
              style: styleLoginButton,
              child: Text(
                "Registrar boton",
                style: loginButton,
              ),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
          ],
        ),
      ),
    );
  }
}
