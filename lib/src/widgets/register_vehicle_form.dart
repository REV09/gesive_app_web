import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/classes/vehiculo_class.dart';
import 'package:gesive_web_app/src/services/services_rest_authentication.dart';
import 'package:gesive_web_app/src/services/services_rest_vehicle.dart';

import '../utils/dialogs.dart';
import '../utils/reg_exp.dart';
import '../utils/responsive.dart';
import 'input_text.dart';

class RegisterVehicleForm extends StatefulWidget {
  String token;
  RegisterVehicleForm({required this.token});

  @override
  _RegisterVehicleForm createState() => _RegisterVehicleForm();
}

class _RegisterVehicleForm extends State<RegisterVehicleForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  ServicesRestVehicle _servicesRestVehicle = ServicesRestVehicle();
  ServicesRestAuthentication _servicesRestAuthentication =
      ServicesRestAuthentication();
  String labelInputSerialNumber = "Numero de serie del vehiculo";
  String labelInputYear = "Año del vehiculo";
  String labelInputBrand = "Marca del vehiculo";
  String labelInputModelo = "Modelo del vehiculo";
  String labelInputColor = "Color del vehiculo";
  String labelInputLicensePlates = "Placas del vehiculo";
  String? _numeroSerie;
  String? _anioVehiculo;
  String? _marca;
  String? _modelo;
  String? _color;
  String? _numeroPlacas;

  void _registrarVehiculo() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null && isOk) {
      ProgressDialog.show(context);
      Conductor conductor =
          await _servicesRestAuthentication.validarTokenConductor(widget.token);
      Vehiculo vehiculo = Vehiculo(
        numeroSerie: _numeroSerie!,
        anio: int.parse(_anioVehiculo!),
        marca: _marca!,
        modelo: _modelo!,
        color: _color!,
        numPlacas: _numeroPlacas!,
        idConductor: conductor.getIdConductor(),
      );
      int statusResponse =
          await _servicesRestVehicle.registrarVehiculo(vehiculo, widget.token);
      _verifyStatusRequest(statusResponse);
    }
  }

  void _verifyStatusRequest(int responseCode) async {
    if (responseCode == 200) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registro completado"),
          content: const Text("Se ha registrado el vehiculo correctamente"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
                ProgressDialog.dismiss(context),
                Navigator.of(context).pop(),
              },
              child: const Text("Aceptar"),
            ),
          ],
        ),
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registro incompleto"),
          content: const Text("Ocurrio un error inesperado y no se completo"
              "el registro"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
                ProgressDialog.dismiss(context),
              },
              child: const Text("Aceptar"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    ButtonStyle registerVehicleButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.teal.shade900,
      fixedSize: Size(
        responsive.wp(27),
        responsive.hp(7.5),
      ),
    );

    TextStyle registerButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.4),
    );

    return Positioned(
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
                label: labelInputSerialNumber,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _numeroSerie = text;
                },
                validator: (text) {
                  if (!alfanumericExpression.hasMatch(text!)) {
                    return "Numero de serie no valido"
                        "\nIngrese solo numeros y letras";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.number,
                label: labelInputYear,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _anioVehiculo = text;
                },
                validator: (text) {
                  if (!numberValidator.hasMatch(text!)) {
                    return "Año no valido"
                        "\nIngrese solo numeros";
                  }
                  if (int.parse(text) < 1900) {
                    return "Año muy antiguo"
                        "\nPor favor ingrese un año mayor o igual a 1900";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                keyboardType: TextInputType.name,
                label: labelInputBrand,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _marca = text;
                },
                validator: (text) {
                  if (!nameValidator.hasMatch(text!)) {
                    return "Marca no valida"
                        "\nIngrese solo letras";
                  }
                  return null;
                },
              ), //aqui
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                label: labelInputModelo,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _modelo = text;
                },
                validator: (text) {
                  if (!modelVehicleValidator.hasMatch(text!)) {
                    return "Modelo no valido"
                        "\nIngrese solo letras, numeros y guiones";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                label: labelInputColor,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _color = text;
                },
                validator: (text) {
                  if (!nameValidator.hasMatch(text!)) {
                    return "Color no valido"
                        "\nIngrese solo letras";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              InputText(
                label: labelInputLicensePlates,
                fontSize: responsive.hp(2.5),
                onChanged: (text) {
                  _numeroPlacas = text;
                },
                validator: (text) {
                  if (!licensePlatesValidator.hasMatch(text!)) {
                    return "Numero de placas no valido"
                        "\nIngrese solo letras, numeros y guiones";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.hp(10),
              ),
              ElevatedButton(
                onPressed: () => {
                  _registrarVehiculo(),
                },
                style: registerVehicleButton,
                child: Text(
                  "Registrar vehiculo",
                  style: registerButton,
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
