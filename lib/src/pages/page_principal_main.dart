import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/pages/page_form_report.dart';
import 'package:gesive_web_app/src/pages/page_history_reports.dart';
import 'package:gesive_web_app/src/pages/page_list_employee.dart';
import 'package:gesive_web_app/src/pages/page_login.dart';
import 'package:gesive_web_app/src/pages/page_register_vehicle.dart';

import '../utils/responsive.dart';

class PrincipalMain extends StatefulWidget {
  String token;
  String sesion;
  String user;
  PrincipalMain({
    required this.token,
    required this.sesion,
    required this.user,
  });

  static const routeName = "principalMain";
  @override
  _PrincipalMain createState() => _PrincipalMain();
}

class _PrincipalMain extends State<PrincipalMain> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

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
        width: responsive.getWidth(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(237, 241, 214, 1.0),
            Color.fromRGBO(157, 192, 139, 1.0),
            Color.fromRGBO(96, 153, 102, 1.0),
            Color.fromRGBO(64, 81, 59, 1.0),
          ], begin: Alignment.topRight, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: responsive.hp(1),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                style: goBackButtonStyle,
                child: const Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(
              height: responsive.hp(3),
            ),
            _sessionView(context, responsive)
          ],
        ),
      ),
    );
  }

  Widget _sessionView(BuildContext context, Responsive responsive) {
    ButtonStyle styleOptions = ElevatedButton.styleFrom(
      backgroundColor: Colors.teal.shade900,
      fixedSize: Size(
        responsive.wp(23),
        responsive.hp(8),
      ),
    );

    TextStyle textOptionButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.5),
    );

    late Column options;
    if (widget.sesion == "Conductor") {
      options = Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: styleOptions,
            child: Text(
              "Polizas de seguro",
              style: textOptionButton,
            ),
          ),
          SizedBox(
            height: responsive.hp(10),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormReportPage(
                    token: widget.token,
                    username: widget.user,
                  ),
                ),
              );
            },
            style: styleOptions,
            child: Text(
              "Levantar reporte",
              style: textOptionButton,
            ),
          ),
          SizedBox(
            height: responsive.hp(10),
          ),
          ElevatedButton(
            onPressed: () {},
            style: styleOptions,
            child: Text(
              "Historial de reportes",
              style: textOptionButton,
            ),
          ),
          SizedBox(
            height: responsive.hp(10),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterVehiclePage(
                    token: widget.token,
                    sesion: widget.sesion,
                    user: widget.user,
                  ),
                ),
              );
            },
            style: styleOptions,
            child: Text(
              "Registrar vehiculo",
              style: textOptionButton,
            ),
          )
        ],
      );
    } else {
      if (widget.sesion == "Ajustador") {
        options = Column(
          children: <Widget>[
            SizedBox(
              height: responsive.hp(10),
            ),
            ElevatedButton(
              onPressed: () {},
              style: styleOptions,
              child: Text(
                "Reportes",
                style: textOptionButton,
              ),
            )
          ],
        );
      } else {
        options = Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryReportsPage(
                      token: widget.token,
                      sesion: widget.sesion,
                      user: widget.user,
                    ),
                  ),
                );
              },
              style: styleOptions,
              child: Text(
                "Reportes",
                style: textOptionButton,
              ),
            ),
            SizedBox(
              height: responsive.hp(10),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListEmployeePage(
                      token: widget.token,
                    ),
                  ),
                );
              },
              style: styleOptions,
              child: Text(
                "Empleados",
                style: textOptionButton,
              ),
            )
          ],
        );
      }
    }
    return Container(
      child: options,
    );
  }
}
