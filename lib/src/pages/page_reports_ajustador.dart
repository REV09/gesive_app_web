import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/classes/reporte_class.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/card_report_content.dart';
import 'package:gesive_web_app/src/widgets/card_widget.dart';
import 'package:logger/logger.dart';

class ReportsAjustador extends StatefulWidget {
  String token;
  String username;
  ReportsAjustador({required this.token, required this.username});

  static const routeName = 'historyReports';
  _ReportsAjustador createState() => _ReportsAjustador();
}

class _ReportsAjustador extends State<ReportsAjustador> {
  String titlePage = "Historial de reportes";
  ServicesRestReporte servicesRestReporte = ServicesRestReporte();
  Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    TextStyle titlePageStyle =
        TextStyle(fontSize: responsive.dp(2), color: Colors.white);

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
                height: responsive.dp(5),
              ),
              Expanded(
                child: FutureBuilder(
                  future: servicesRestReporte.reportesAjustador(widget.username, widget.token),
                  builder: ((context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          Reporte reporte = snapshot.data!.elementAt(index);
                          _logger.i(reporte.getInvolucradosNombres());
                          SizedBox space = SizedBox(
                            height: responsive.hp(2.5),
                          );
                          ReportCardContent card = ReportCardContent(
                            constraints: BoxConstraints(
                              maxWidth: responsive.dp(41),
                              minHeight: responsive.hp(18),
                            ),
                            child: createCardContent(reporte, context),
                          );

                          ElementCard reportCard = ElementCard(
                            color: Colors.white,
                            elevation: 10,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: card,
                          );

                          return Column(
                            children: <Widget>[space, reportCard],
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createCardContent(Reporte reporte, BuildContext context) {
    Responsive responsive = Responsive(context);
    List<String> involvedPersons = reporte.getInvolucradosNombres().split(";");
    List<String> involvedVehicles =
        reporte.getInvolucradosVehiculos().split(";");

    List<Widget> listPersons = List.empty(growable: true);
    List<Widget> listVehicles = List.empty(growable: true);

    String dictamenDate =
        "${reporte.getDictamenFecha().year}-${reporte.getDictamenFecha().month}-${reporte.getDictamenFecha().day}";

    TextStyle reportInfoStyle =
        TextStyle(fontSize: responsive.dp(1.2), color: Colors.black);

    for (var i = 0; i < involvedPersons.length; i++) {
      listPersons.add(
        SizedBox(
          height: responsive.hp(0.7),
        ),
      );
      listPersons.add(
        SizedBox(
          child: Text(
            involvedPersons.elementAt(i),
            style: reportInfoStyle,
          ),
        ),
      );
    }

    for (var i = 0; i < involvedVehicles.length; i++) {
      listVehicles.add(
        SizedBox(
          height: responsive.hp(0.7),
        ),
      );
      listVehicles.add(
        SizedBox(
          child: Text(
            involvedVehicles.elementAt(i),
            style: reportInfoStyle,
          ),
        ),
      );
    }

    return Row(
      children: <Widget>[
        SizedBox(
          width: responsive.dp(1.4),
        ),
        SizedBox(
          child: Text(
            reporte.getIdReporte().toString(),
            style: reportInfoStyle,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.8),
        ),
        SizedBox(
          child: Text(
            reporte.getEstatus(),
            style: reportInfoStyle,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.8),
        ),
        SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listPersons,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.4),
        ),
        SizedBox(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listVehicles),
        ),
        SizedBox(
          width: responsive.dp(2),
        ),
        SizedBox(
          child: Text(
            reporte.getDictamenTexto(),
            style: reportInfoStyle,
          ),
        ),
        SizedBox(
          width: responsive.dp(1.4),
        ),
        SizedBox(
          child: Text(
            dictamenDate,
            style: reportInfoStyle,
          ),
        ),
      ],
    );
  }
}
