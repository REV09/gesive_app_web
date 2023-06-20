import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/classes/pago_class.dart';
import 'package:gesive_web_app/src/classes/poliza_class.dart';
import 'package:gesive_web_app/src/classes/vehiculo_class.dart';
import 'package:gesive_web_app/src/pages/page_list_insurance_policy.dart';
import 'package:gesive_web_app/src/services/services_rest_authentication.dart';
import 'package:gesive_web_app/src/services/services_rest_pay.dart';
import 'package:gesive_web_app/src/services/services_rest_policy.dart';
import 'package:gesive_web_app/src/services/services_rest_vehicle.dart';
import 'package:intl/intl.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/pages/page_login.dart';
import 'package:gesive_web_app/src/services/servicios_rest_conductor.dart';
import 'package:gesive_web_app/src/utils/dialogs.dart';
import 'package:gesive_web_app/src/utils/reg_exp.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/input_text.dart';
import 'package:intl/intl.dart';

class InsurancePolicyForm extends StatefulWidget {
  String token;

  InsurancePolicyForm({required this.token});

  @override
  _InsurancePolicyFormState createState() => _InsurancePolicyFormState();
}

class _InsurancePolicyFormState extends State<InsurancePolicyForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final ServicesRestPoliza _serviceRestPolicy = ServicesRestPoliza();
  final ServicesRestPago _serviceRestPay = ServicesRestPago();
  final ServicesRestVehicle _servicesRestVehicle = ServicesRestVehicle();
  ServicesRestAuthentication _servicesRestAuthentication =
      ServicesRestAuthentication();
  String labelInputPolicyTerm = "Plazo (Duración)";
  String labelInputCoverageType = "Tipo de cobertura";
  String labelPurchaseCost = "Costo";
  List<String> durationOptions = ['1 año', '2 años', '3 años'];
  Vehiculo? _vehiculoSeleccionado;
  int? _duracionSeleccionada;
  int? _duracionDias;
  String? _tipoCoberturaSeleccionada;
  DateTime? _FechaRegistro = DateTime.now();
  bool _showAdditionalFields = false;
  int? _costo = 0;
  bool? _metodoPago;
  String? _numeroTarjeta;
  String? _fechaVencimiento;
  String? _cvv;
  bool _showButton = true;
  bool _editableFields = true;

  List<Vehiculo> _listaVehiculos = [];

  void cargarListaVehiculos() async {
    try {
      Conductor conductor =
          await _servicesRestAuthentication.validarTokenConductor(widget.token);
      _listaVehiculos =
          await _servicesRestVehicle.obtenerListaVehiculos(widget.token);
    } catch (error) {
      print("Error al obtener la lista de vehículos: $error");
    }
  }

  Future<void> _registrarPoliza() async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        ProgressDialog.show(context);
        Conductor conductor = await _servicesRestAuthentication
            .validarTokenConductor(widget.token);
        Poliza poliza = Poliza(
          idPoliza: 0,
          idConductor: conductor.getIdConductor(),
          idVehiculo: _vehiculoSeleccionado!.getIdVehiculo(),
          fechaInicio: _FechaRegistro!,
          fechaFin: _FechaRegistro!.add(Duration(days: _duracionDias!)),
          plazo: _duracionSeleccionada!,
          tipoCobertura: _tipoCoberturaSeleccionada!,
          costo: _costo!,
        );
        int statusResponse =
            await _serviceRestPolicy.registrarPoliza(poliza, widget.token);
        _verifyStatusRequest(statusResponse);
        print(statusResponse);
      }
    }
  }

  Future<void> _registrarPago(int idPolizaObtenida) async {
    final isOk = _formKey.currentState?.validate();
    if (isOk != null) {
      if (isOk) {
        ProgressDialog.show(context);
        Conductor conductor = await _servicesRestAuthentication
            .validarTokenConductor(widget.token);
        Pago pago = Pago(
          idPago: 0,
          idPoliza: idPolizaObtenida,
          idConductor: conductor.getIdConductor(),
          monto: _costo!,
          fecha: _FechaRegistro!,
          formaDePago: _metodoPago!,
          numeroDeTarjeta: _numeroTarjeta!,
          fechaVencimiento: _fechaVencimiento!,
          cvv: _cvv!,
        );
        int statusResponse =
            await _serviceRestPay.registrarPago(pago, widget.token);
        _verifyStatusRequest(statusResponse);
      }
    }
  }

  void _verifyStatusRequest(int responseCode) async {
    if (responseCode == 200) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registro completado"),
          content: Text("Se ha registrado la nueva póliza"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text("Aceptar"),
            ),
          ],
        ),
      );
      ProgressDialog.dismiss(context);
      Navigator.of(context).pop();
      Navigator.pushNamed(context, InsurancePolicyPage.routeName);
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registro incompleto"),
          content: const Text("Ocurrio un error inesperado y no se completo"
              "el registro"),
          actions: <Widget>[
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text("Aceptar"),
            ),
          ],
        ),
      );
      ProgressDialog.dismiss(context);
    }
  }

  Future<void> _procesoPoliza() async {
    await _registrarPoliza();
    int idPolizaCreada = await _serviceRestPolicy.obtenerIdPolizaPorIdVehiculo(
        _vehiculoSeleccionado!.getIdVehiculo(), widget.token);
    _registrarPago(idPolizaCreada);
  }

  @override
  void initState() {
    super.initState();
    cargarListaVehiculos();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    TextStyle purchaseButton = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2.4),
    );

    TextStyle costLabel = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: responsive.hp(2),
    );

    ButtonStyle stylePurchaseButton = ElevatedButton.styleFrom(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(
                      10), // Ajusta el valor para cambiar el radio de los bordes
                ),
                constraints: BoxConstraints(
                  maxWidth: responsive.wp(65),
                  minWidth: responsive.wp(50),
                ),
                child: Column(
                  children: [
                    DropdownButton<Vehiculo>(
                      hint: Text("Seleccione un vehiculo"),
                      value: _vehiculoSeleccionado,
                      items: _listaVehiculos.map((vehiculo) {
                        return DropdownMenuItem<Vehiculo>(
                          value: vehiculo,
                          child: Text(
                              '${vehiculo.marca} ${vehiculo.modelo} (${vehiculo.numPlacas})'),
                        );
                      }).toList(),
                      onChanged: _editableFields
                          ? (value) {
                              setState(() {
                                _vehiculoSeleccionado = value!;
                              });
                            }
                          : null,
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    DropdownButton<int>(
                      hint: Text("Plazo deseado"),
                      value: _duracionSeleccionada,
                      items: const [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('1 año'),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('2 años'),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text('3 años'),
                        ),
                      ],
                      onChanged: _editableFields
                          ? (value) {
                              setState(() {
                                _duracionSeleccionada = value!;
                                _duracionDias = value * 365;
                              });
                            }
                          : null,
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    DropdownButton<String>(
                      hint: Text("Tipo de Cobertura deseada"),
                      value: _tipoCoberturaSeleccionada,
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'Básica',
                          child: Text('Básica'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Estandar',
                          child: Text('Estándar'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Premium',
                          child: Text('Premium'),
                        ),
                      ],
                      onChanged: _editableFields
                          ? (value) {
                              setState(() {
                                _tipoCoberturaSeleccionada = value!;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.hp(4),
              ),
              Visibility(
                visible: _showAdditionalFields,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: responsive.wp(65),
                    minWidth: responsive.wp(50),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total a pagar: $_costo pesos mexicanos",
                        textAlign: TextAlign.center,
                        style: costLabel,
                      ),
                      SizedBox(
                        height: responsive.hp(3),
                      ),
                      Text(
                        "Fecha registrada para el pago: $_FechaRegistro",
                        textAlign: TextAlign.center,
                        style: costLabel,
                      ),
                      SizedBox(
                        height: responsive.hp(3),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: false,
                            groupValue: _metodoPago,
                            activeColor: Colors.teal.shade900,
                            onChanged: (value) {
                              setState(() {
                                _metodoPago = value;
                                print(_metodoPago);
                              });
                            },
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pago en débito',
                              textAlign: TextAlign.center,
                              style: costLabel,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: true,
                            groupValue: _metodoPago,
                            activeColor: Colors.teal.shade900,
                            onChanged: (value) {
                              setState(() {
                                _metodoPago = value;
                                print(_metodoPago);
                              });
                            },
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pago en crédito',
                              textAlign: TextAlign.center,
                              style: costLabel,
                            ),
                          ),
                        ],
                      ),
                      InputText(
                        label: "Número de Tarjeta",
                        fontSize: responsive.hp(2.5),
                        onChanged: (text) {
                          _numeroTarjeta = text;
                        },
                        validator: (text) {
                          if (!cardExtensionValidator.hasMatch(text!)) {
                            return "Numero de Tarjeta no valido"
                                "\nIngrese solo numeros y recuerde sus 16 digitos";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: responsive.hp(4),
                      ),
                      InputText(
                        label: "Fecha de vencimiento",
                        fontSize: responsive.hp(2.5),
                        onChanged: (text) {
                          _fechaVencimiento = text;
                        },
                        validator: (text) {
                          if (!expirationDateValidator.hasMatch(text!)) {
                            return "Fecha no valido"
                                "\nIngrese correctamente el formato MM/AA";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: responsive.hp(4),
                      ),
                      InputText(
                        label: "CVV (Card Verification Value)",
                        fontSize: responsive.hp(2.5),
                        onChanged: (text) {
                          _fechaVencimiento = text;
                        },
                        validator: (text) {
                          if (!cvvValidator.hasMatch(text!)) {
                            return "CVV no valido"
                                "\nIngrese correctamente el formato";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: responsive.hp(4),
              ),
              Visibility(
                visible: _showButton,
                child: ElevatedButton(
                  onPressed: () {
                    if (_vehiculoSeleccionado != null &&
                        _duracionSeleccionada != null &&
                        _tipoCoberturaSeleccionada != null) {
                      _costo = calcularCosto();
                      _FechaRegistro = DateTime.now();
                      print(_FechaRegistro);
                      print(
                          _FechaRegistro!.add(Duration(days: _duracionDias!)));
                      setState(() {
                        _showAdditionalFields = !_showAdditionalFields;
                        _showButton = false;
                        _editableFields = !_editableFields;
                      });
                    }
                  },
                  style: stylePurchaseButton,
                  child: Text(
                    "Proceder al pago",
                    style: purchaseButton,
                  ),
                ),
              ),
              Visibility(
                visible: !_showButton,
                child: ElevatedButton(
                  onPressed: () {
                    if (_metodoPago != null) {
                      final isOk = _formKey.currentState?.validate();
                      _procesoPoliza();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Formato de Pago Pendiente"),
                          content: const Text(
                              "Recuerda seleccionar el tipo de tarjeta que utilizas"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => {
                                Navigator.of(context).pop(),
                              },
                              child: const Text("Aceptar"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: stylePurchaseButton,
                  child: Text(
                    "Comprar Poliza",
                    style: purchaseButton,
                  ),
                ),
              ),
              SizedBox(
                height: responsive.hp(5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? calcularCosto() {
    int total = 0;
    if (_tipoCoberturaSeleccionada == 'Básica') {
      if (_duracionSeleccionada == 1) {
        total = 1000;
      } else if (_duracionSeleccionada == 2) {
        total = 1800;
      } else if (_duracionSeleccionada == 3) {
        total = 2500;
      }
    } else if (_tipoCoberturaSeleccionada == 'Estandar') {
      if (_duracionSeleccionada == 1) {
        total = 1500;
      } else if (_duracionSeleccionada == 2) {
        total = 2700;
      } else if (_duracionSeleccionada == 3) {
        total = 3750;
      }
    } else if (_tipoCoberturaSeleccionada == 'Premium') {
      if (_duracionSeleccionada == 1) {
        total = 2000;
      } else if (_duracionSeleccionada == 2) {
        total = 3600;
      } else if (_duracionSeleccionada == 3) {
        total = 5000;
      }
    }
    return total;
  }
}
