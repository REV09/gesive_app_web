import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/pages/page_login.dart';
import 'package:gesive_web_app/src/services/servicios_rest_conductor.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final ServiceRestConductor _serviceRestConductor = ServiceRestConductor();
  String labelInputFullName = "Nombre completo";
  String labelInputLicenseNumber = "Numero de licencia";
  String labelInputBornDate = "Fecha de nacimiento";
  String labelInputPhoneNumber = "Numero de telefono";
  String labelInputPassword = "Contraseña";
  String labelInputConfirmPassword = "Confirmar Contraseña";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? _nombreCompleto;
  String? _numeroLicencia;
  String? _fechaNacimiento;
  String? _numeroTelefono;
  String? _contrasena;
  String? _confirmarContrasena;

  void _registrarConductor() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        ProgressDialog.show(context);
        Conductor conductor = Conductor(
            nombreCompleto: _nombreCompleto!,
            numLicencia: _numeroLicencia!,
            fechaNacimiento: _fechaNacimiento!,
            telefono: _numeroTelefono!,
            contrasena: _contrasena!);
        int statusResponse =
            await _serviceRestConductor.registrarConductor(conductor);
        _verifyStatusRequest(statusResponse);
      }
    }
  }

  void _verifyStatusRequest(int responseCode) async {
    if (responseCode == 200) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registro completado"),
          content: Text("Se ha registrado el usuario $_numeroTelefono"
              "\nCon contraseña: $_contrasena"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text("Aceptar"),
            ),
          ],
        ),
      );
      ProgressDialog.dismiss(context);
      Navigator.of(context).pop();
      Navigator.pushNamed(context, LoginPage.routeName);
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registro incompleto"),
          content: const Text("Ocurrio un error inesperado y no se completo"
              "el registro"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text("Aceptar"),
            ),
          ],
        ),
      );
      ProgressDialog.dismiss(context);
    }
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.name,
                label: labelInputFullName,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _nombreCompleto = text;
                },
                validator: (text) {
                  if (!alfabeticCharacters.hasMatch(text!)) {
                    return "Nombre no valido"
                        "\nIngrese solo letras y espacios";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.text,
                label: labelInputLicenseNumber,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _numeroLicencia = text;
                },
                validator: (text) {
                  if (!alfanumericExpression.hasMatch(text!)) {
                    return "Numero de licencia no valido"
                        "\nIngrese solo letras y numeros";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.datetime,
                label: labelInputBornDate,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  DateTime date = DateTime.tryParse(text)!;
                  _fechaNacimiento = formatter.format(date);
                },
                validator: (text) {
                  if (!dateValidator.hasMatch(text!)) {
                    return "Formato de fecha no valido"
                        "\nIngrese la fecha en formato YYYY-MM-DD";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.number,
                label: labelInputPhoneNumber,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _numeroTelefono = text;
                },
                validator: (text) {
                  if (!numberValidator.hasMatch(text!)) {
                    return "Numero de telefono no valido"
                        "\nPorfavor ingrese solo numeros";
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
                        obscureText: obscurePassword,
                        borderEnabled: false,
                        fontSize: responsive.hp(2.5),
                        onChanged: (text) {
                          _contrasena = text;
                        },
                        validator: (text) {
                          if (!alfanumericExpression.hasMatch(text!)) {
                            return "Contraseña no valida"
                                "\nIngrese una clave valida";
                          }
                          return null;
                        },
                      ),
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
                        fontSize: responsive.hp(2.5),
                        onChanged: (text) {
                          _confirmarContrasena = text;
                        },
                        validator: (text) {
                          if (alfanumericExpression.hasMatch(text!)) {
                            if (_confirmarContrasena == _contrasena) {
                              return null;
                            }
                            return "Las contraseñas no coinciden";
                          }
                          return "Contraseña no valida";
                        },
                      ),
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
                onPressed: () => {
                  _registrarConductor(),
                },
                style: styleLoginButton,
                child: Text(
                  "Registrarse",
                  style: loginButton,
                ),
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
