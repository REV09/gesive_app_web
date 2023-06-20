import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/classes/vehiculo_class.dart';
import 'package:gesive_web_app/src/pages/page_history_reports.dart';
import 'package:gesive_web_app/src/services/services_rest_employee.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/services/services_rest_vehicle.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/globals.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

import '../classes/empleado_class.dart';
import '../classes/poliza_class.dart';
import '../classes/reporte_class.dart';
import '../services/services_rest_policy.dart';
import '../services/servicios_rest_conductor.dart';

class ReportView extends StatefulWidget {
  String token;
  String username;
  Reporte reporte;
  ReportView({required this.token, required this.username, required this.reporte});


  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final ServicesRestReporte _servicesRestReporte = ServicesRestReporte();
  String labelInputPolicy = "Póliza";
  String labelInputInvolvedNames = "Nombres de involucrados";
  String labelInputInvolvedVehicles = "Vehículos involucrados";
  String labelInputPhotos = "Fotos de siniestro";
  String labelInputDictamen = "Dictamen";
  String? _dictamen;
  DateTime? _dictamenFecha;
  String? _dictamenHora;
  String? _dictamenFolio;
  List<String> _fotos = List<String>.empty(growable: true);
  Reporte? _reporte;

  _dictaminar() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        _reporte = widget.reporte;
        ProgressDialog.show(context);
        _reporte!.dictamenFolio = "F${DateTime.now().millisecondsSinceEpoch}";
        _reporte!.dictamenTexto = _dictamen!;
        int statusResponse =
          await _servicesRestReporte.actualizarReporte(_reporte!, widget.token);
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
            children: <Widget>[
              Text(labelInputPolicy, style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              Text(labelInputPolicy, style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              DropdownPolizas(username: widget.username, token: widget.token),
              SizedBox(
                height: responsive.hp(10),
              ),
              Text(labelInputInvolvedNames, style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              SizedBox(
                height: responsive.hp(10),
              ),
              Text(labelInputInvolvedVehicles, style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              SizedBox(
                height: responsive.hp(10),
              ),
              Text(labelInputPhotos, style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              SizedBox(
                height: responsive.hp(2),
              ),
              
              SizedBox(
                height: responsive.hp(2),
              ),
              Text("$fileQuantity $labelSelectedPhotos", style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.name,
                label: labelInputDictamen,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _dictamen = text;
                },
                validator: (text) {
                  if (!alfanumericExpression.hasMatch(text!)) {
                    return "No se puede dejar campo vacio";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () => {
                  _dictaminar(),
                },
                style: styleLoginButton,
                child: Text(
                  "Registrar siniestro",
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

class DropdownPolizas extends StatefulWidget {
  String username;
  String token;
  DropdownPolizas({required this.username, required this.token});

  @override
  State<DropdownPolizas> createState() => _DropdownPolizasState();
}

class _DropdownPolizasState extends State<DropdownPolizas> {
  int dropdownValue = 0;
  Conductor? conductor;
  List<Poliza> polizas = List<Poliza>.empty(growable: true);
  Map<int ,String> vehiculos = <int, String>{};

  @override
  initState() {
    super.initState();
    obtenerDatos();
  }

  obtenerDatos() async {
    ServiceRestConductor _servicesRestConductor = ServiceRestConductor();
    ServicesRestPoliza _servicesRestPoliza = ServicesRestPoliza();
    ServicesRestVehicle _servicesRestVehicle = ServicesRestVehicle();

    conductor = await _servicesRestConductor.obtenerConductorByPhone(widget.username, widget.token);
    polizas = await _servicesRestPoliza.obtenerPolizasUsuario(conductor!.getIdConductor());

    for(Poliza poliza in polizas) {
      Vehiculo vehiculo = await _servicesRestVehicle.obtenerVehiculo(poliza.idVehiculo, widget.token);
      vehiculos[poliza.idPoliza] = "${vehiculo.getMarca()} ${vehiculo.getModelo()} ${vehiculo.getAnio()} ${vehiculo.getNumPlacas()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);


    return Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.blueGrey),
        child: DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            style: TextStyle(fontSize: responsive.hp(2.5), color: Colors.white),
            items: polizas
                .map((e) => DropdownMenuItem(value: e.idPoliza, child: Text(vehiculos[e.idPoliza] ?? "")))
                .toList(),
            onChanged: (int? value) {
              setState(() {
                dropdownValue = value!;
              });
            }
        )
    );
  }

}
