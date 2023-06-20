import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/classes/vehiculo_class.dart';
import 'package:gesive_web_app/src/pages/page_history_reports.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/services/services_rest_vehicle.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';

import '../classes/poliza_class.dart';
import '../classes/reporte_class.dart';
import '../services/services_rest_policy.dart';
import '../services/servicios_rest_conductor.dart';

class ReportForm extends StatefulWidget {
  String token;
  String username;
  ReportForm({required this.token, required this.username});


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
  int fileQuantity = 0;
  String labelSelectedPhotos = " archivo(s) seleccionado(s).";
  int? _idPoliza;
  String? _involucradosNombres;
  String? _involucradosVehiculos;
  List<String> _fotos = List<String>.empty(growable: true);
  double? _posLat;
  double? _posLon;

  _registrarReporte() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        var geoposition = await Geolocator.getCurrentPosition();
        ProgressDialog.show(context);
        Reporte reporte = Reporte(
          idReporte: 100,
          idPoliza: _idPoliza!,
          posicionLat: geoposition.latitude,
          posicionLon: geoposition.longitude,
          involucradosNombres: _involucradosNombres!,
          involucradosVehiculos: _involucradosVehiculos!,
          fotos: "",
          idAjustador: 420,
          estatus: "pendiente",
          dictamenTexto: "",
          dictamenFecha: DateTime(1970, 01, 01),
          dictamenHora: "",
          dictamenFolio: "",);
        int statusResponse =
          await _servicesRestReporte.registrarReporte(reporte, _fotos, widget.token);
        ProgressDialog.dismiss(context);
        Navigator.of(context).pop();
        Navigator.pushNamed(context, HistoryReportsPage.routeName);
      }
    }
  }

  _abrirArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      _fotos = List<String>.empty(growable: true);
      for(var file in result.files) {
        _fotos.add(file.bytes.toString());
      }
    }

    setState(() {
      fileQuantity = _fotos.length;
    });
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
              DropdownPolizas(username: widget.username, token: widget.token),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.name,
                label: labelInputInvolvedNames,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _involucradosNombres = text;
                },
                validator: (text) {
                  if (!alfabeticCharacters.hasMatch(text!)) {
                    return "Nombre(s) no valido(s)"
                        "\nIngrese solo letras y espacios";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.name,
                label: labelInputInvolvedVehicles,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _involucradosVehiculos = text;
                },
                validator: (text) {
                  if (!alfanumericExpression.hasMatch(text!)) {
                    return "Vehiculos(s) no valido(s)"
                        "\nIngrese solo letras, números y espacios";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              Text(labelInputPhotos, style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              SizedBox(
                height: responsive.hp(2),
              ),
              ElevatedButton(
                onPressed: () => {
                  _abrirArchivos()
                },
                style: styleLoginButton,
                child: Text(
                  "Seleccionar fotos...",
                  style: loginButton,
                ),
              ),
              SizedBox(
                height: responsive.hp(2),
              ),
              Text("$fileQuantity $labelSelectedPhotos", style: TextStyle(fontSize: responsive.hp(2.4), color: Colors.white),),
              SizedBox(
                height: responsive.hp(10),
              ),
              ElevatedButton(
                onPressed: () => {
                  _registrarReporte(),
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
    polizas = await _servicesRestPoliza.obtenerPolizasUsuario(conductor!.getIdConductor(), widget.token);

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
