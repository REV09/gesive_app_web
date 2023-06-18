import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/pages/page_history_reports.dart';
import 'package:gesive_web_app/src/pages/page_list_employee.dart';
import 'package:gesive_web_app/src/pages/page_login.dart';

import '../utils/responsive.dart';

class PrincipalMain extends StatefulWidget {
  String token;
  String sesion;
  String user;
  PrincipalMain(
      {required this.token, required this.sesion, required this.user});

  static const routeName = "principalMain";
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
            _sessionView()
          ],
        ),
      ),
    );
  }

  Widget _sessionView() {
    late Column options;
    if (widget.sesion == "Conductor") {
      options = Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            child: const Text("Polizas de seguro"),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Levantar reporte"),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Historial de reportes"),
          )
        ],
      );
    } else {
      if (widget.sesion == "Ajustador") {
        options = Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              child: const Text("Reportes"),
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
                    ),
                  ),
                );
              },
              child: const Text("Reportes"),
            ),
            const SizedBox(
              height: 50,
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
              child: const Text("Empleados"),
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
