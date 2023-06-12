import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/pages/page_form_employee.dart';
import 'package:gesive_web_app/src/services/services_rest_employee.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

import '../classes/empleado_class.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  GlobalKey<FormState> _formKey = GlobalKey(); //?
  final ServicesRestEmpleado _servicesRestEmpleado = ServicesRestEmpleado();
  String labelInputFullName = "Nombre completo";
  String labelInputJoinDate = "Fecha de ingreso";
  String labelInputRole = "Cargo";
  String labelInputUserName = "Nombre de usuario";
  String labelInputPassword = "Contraseña";
  String labelInputConfirmPassword = "Confirmar Contraseña";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? _nombreCompleto;
  DateTime? _fechaIngreso;
  String? _cargo;
  String? _nombreUsuario;
  String? _contrasena;
  String? _confirmarContrasena;

  _registrarEmpleado() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        ProgressDialog.show(context);
        Empleado empleado = Empleado(
            idEmpleado: 42, // i guess
            nombreCompleto: _nombreCompleto!,
            fechaIngreso: _fechaIngreso!,
            cargo: _cargo!,
            nombreUsuario: _nombreUsuario!,
            contrasena: _contrasena!);
        //empleado.setIdEmpleado(42); //??
        int statusResponse =
          await _servicesRestEmpleado.registrarEmpleado(empleado);
        ProgressDialog.dismiss(context);
        Navigator.of(context).pop();
        Navigator.pushNamed(context, FormEmployeePage.routename);
      }
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
                keyboardType: TextInputType.datetime,
                label: labelInputJoinDate,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _fechaIngreso = DateTime.tryParse(text);
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
                keyboardType: TextInputType.text,
                label: labelInputRole,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _cargo = text;
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
                keyboardType: TextInputType.number,
                label: labelInputUserName,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _nombreUsuario = text;
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
                  _registrarEmpleado(),
                },
                style: styleLoginButton,
                child: Text(
                  "Registrar empleado",
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
