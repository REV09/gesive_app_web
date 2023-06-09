import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/pages/page_register.dart';
import 'package:gesive_web_app/src/services/servicios_rest_conductor.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String labelInputEmail = "Telefono o usuario";
  String labelInputPassword = "Contraseña";
  String? _phoneOrUserName;
  String? _password;

  final ServiceRestConductor _serviceRestConductor = ServiceRestConductor();

  _autenticarUsuario() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        ProgressDialog.show(context);
        Conductor conductor = Conductor.inicioSesion(
            telefono: _phoneOrUserName!, contrasena: _password!);
        int statusResponse =
            await _serviceRestConductor.autenticateLogin(conductor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    TextStyle forgotPasswordStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.1),
    );

    TextStyle registerButton = TextStyle(
      color: Colors.purple.shade800,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.3),
    );

    TextStyle loginButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.4),
    );

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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: labelInputEmail,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _phoneOrUserName = text;
                },
                validator: (text) {
                  if (!alfanumericExpression.hasMatch(text!)) {
                    return "Telefono invalido";
                  }
                  return null;
                },
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
                        obscureText: true,
                        borderEnabled: false,
                        fontSize: responsive.hp(2.5),
                        onChanged: (text) {
                          _password = text;
                        },
                        validator: (text) {
                          if (specialCharacters.hasMatch(text!)) {
                            return "Contraseña invalida";
                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        "Olvidaste tu contraseña?",
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
                onPressed: () => {_autenticarUsuario()},
                style: styleLoginButton,
                child: Text(
                  "Iniciar sesion",
                  style: loginButton,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "¿Eres nuevo por aqui?",
                    style: forgotPasswordStyle,
                  ),
                  SizedBox(
                    height: responsive.hp(10),
                    width: responsive.wp(4),
                  ),
                  TextButton(
                      onPressed: () => {
                            Navigator.pushNamed(
                              context,
                              RegisterClientPage.routeName,
                            )
                          },
                      child: Text(
                        "Registrate gratis",
                        style: registerButton,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
