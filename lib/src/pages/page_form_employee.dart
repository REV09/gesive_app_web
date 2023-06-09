import 'package:flutter/material.dart';

import '../services/services_rest_employee.dart';
import '../utils/responsive.dart';
import '../widgets/employee_form.dart';

class FormEmployeePage extends StatefulWidget {
  String token;

  FormEmployeePage({required this.token});

  static const routename = "formEmployee";
  _FormEmployeePage createState() => _FormEmployeePage();
}

class _FormEmployeePage extends State<FormEmployeePage> {
  String titlePage = "Empleado";
  ServicesRestEmpleado servicesRestEmpleado = ServicesRestEmpleado();

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    const String title = "Registrar nuevo empleado";
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: goBackButtonStyle,
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: responsive.dp(15),
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: textLoginStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.dp(5),
                  ),
                  EmployeeForm(
                    token: widget.token,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
