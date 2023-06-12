import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/pages/page_form_employee.dart';
import 'package:gesive_web_app/src/services/services_rest_employee.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/card_report_content.dart';
import 'package:gesive_web_app/src/widgets/card_widget.dart';

class ListEmployeePage extends StatefulWidget {
  static const routeName = "listEmployee";
  _ListEmployeePage createState() => _ListEmployeePage();
}

class _ListEmployeePage extends State<ListEmployeePage> {
  String titlePage = "Lista de empleados";
  ServicesRestEmpleado servicesRestEmpleado = ServicesRestEmpleado();

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    TextStyle titlePageStyle =
        TextStyle(fontSize: responsive.dp(2), color: Colors.white);

    ButtonStyle styleRegisterEmployeeButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.teal.shade900,
      fixedSize: Size(
        responsive.wp(23.6),
        responsive.hp(7.5),
      ),
    );

    TextStyle registerButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.4),
    );

    return Scaffold(
      body: Container(
        child: Container(
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
                height: responsive.hp(5),
              ),
              Text(
                titlePage,
                textAlign: TextAlign.center,
                style: titlePageStyle,
              ),
              SizedBox(
                height: responsive.hp(5),
              ),
              ElevatedButton(
                onPressed: () => {Navigator.pushNamed(context, FormEmployeePage.routename)},
                style: styleRegisterEmployeeButton,
                child: Text(
                  "Registrar empleado",
                  style: registerButton,
                ),
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              Expanded(
                child: FutureBuilder(
                  future: servicesRestEmpleado.obtenerEmpleados(),
                  builder: ((context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          Empleado empleado = snapshot.data!.elementAt(index);
                          print(empleado.getNombreCompleto());
                          SizedBox space = SizedBox(
                            height: responsive.hp(2.5),
                          );
                          ReportCardContent card = ReportCardContent(
                            constraints: BoxConstraints(
                              maxWidth: responsive.dp(34.6),
                              minHeight: responsive.hp(18),
                            ),
                            child: createCardContent(empleado, context),
                          );

                          ElementCard employeeCard = ElementCard(
                            color: Colors.white,
                            elevation: 10,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: card,
                          );

                          return Column(
                            children: <Widget>[space, employeeCard],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createCardContent(Empleado employee, BuildContext context) {
    Responsive responsive = Responsive(context);
    TextStyle employeeInfoStyle =
        TextStyle(fontSize: responsive.dp(1.2), color: Colors.black);

    String fullName = employee.getNombreCompleto();
    String cargo = employee.getCargo();
    String userName = employee.getNombreUsuario();

    return Row(
      children: <Widget>[
        SizedBox(
          width: responsive.dp(1.4),
        ),
        SizedBox(
          child: Text(
            fullName,
            style: employeeInfoStyle,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.4),
        ),
        SizedBox(
          child: Text(
            cargo,
            style: employeeInfoStyle,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.4),
        ),
        SizedBox(
          child: Text(
            userName,
            style: employeeInfoStyle,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.4),
        ),
      ],
    );
  }
}
