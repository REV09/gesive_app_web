import 'package:flutter/material.dart';

import '../services/services_rest_employee.dart';
import '../utils/responsive.dart';
import '../widgets/report_form.dart';

class FormReportPage extends StatefulWidget {
  String token;
  String username;
  FormReportPage({required this.token, required this.username});

  static const routename = "formReport";
  _FormReportPage createState() => _FormReportPage();
}

class _FormReportPage extends State<FormReportPage> {
  String titlePage = "Reportar siniestro";
  ServicesRestEmpleado servicesRestEmpleado = ServicesRestEmpleado();

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    const String title = "Registrar siniestro";
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
                  ReportForm(token: widget.token, username: widget.username,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
