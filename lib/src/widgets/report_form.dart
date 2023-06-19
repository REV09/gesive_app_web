import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/pages/page_history_reports.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

import '../classes/empleado_class.dart';
import '../classes/reporte_class.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final ServicesRestReporte _servicesRestReporte = ServicesRestReporte();
  String labelInputPolicy = "Póliza";
  String labelInputInvolvedNames = "Nombres de involucrados";
  String labelInputInvolvedVehicles = "Vehículos involucrados";
  String labelInputPhotos = "Fotos de siniestro";
  int? _idPoliza;
  String? _involucradosNombres;
  String? _involucradosVehiculos;
  String? _fotos;
  double? _posLat;
  double? _posLon;

  _registrarReporte() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        ProgressDialog.show(context);
        Reporte reporte = Reporte(
          idReporte: 69,
          idPoliza: _idPoliza!,
          posicionLat: _posLat!,
          posicionLon: _posLon!,
          involucradosNombres: _involucradosNombres!,
          involucradosVehiculos: _involucradosVehiculos!,
          fotos: _fotos!,
          idAjustador: 420,
          estatus: "pendiente", //????
          dictamenTexto: "",
          dictamenFecha: DateTime(1970, 01, 01),
          dictamenHora: "",
          dictamenFolio: "",);
        int statusResponse =
        //await _servicesRestReporte.registrarReporte(reporte);
        ProgressDialog.dismiss(context);
        Navigator.of(context).pop();
        Navigator.pushNamed(context, HistoryReportsPage.routeName);
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

          ),
        ),
      ),
    );
  }
}
