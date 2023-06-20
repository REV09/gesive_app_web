import 'package:flutter/material.dart';
import 'package:gesive_web_app/src/classes/poliza_class.dart';
import 'package:gesive_web_app/src/pages/page_form_insurance_policy.dart';
import 'package:gesive_web_app/src/pages/page_principal_main.dart';
import 'package:gesive_web_app/src/services/services_rest_authentication.dart';
import 'package:gesive_web_app/src/services/services_rest_policy.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';
import 'package:gesive_web_app/src/utils/responsive.dart';
import 'package:gesive_web_app/src/widgets/card_report_content.dart';
import 'package:gesive_web_app/src/widgets/card_widget.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../classes/conductor_clase.dart';

class InsurancePolicyPage extends StatefulWidget {
  String token;
  String sesion;
  String user;
  InsurancePolicyPage(
      {required this.token, required this.sesion, required this.user});

  static const routeName = 'listInsurancePolicy';
  _InsurancePolicyPage createState() => _InsurancePolicyPage();
}

class _InsurancePolicyPage extends State<InsurancePolicyPage> {
  String titlePage = "Pólizas de seguro";
  ServicesRestReporte servicesRestReporte = ServicesRestReporte();
  ServicesRestPoliza servicesRestPoliza = ServicesRestPoliza();
  Logger _logger = Logger();
  Conductor? conductor;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    TextStyle titlePageStyle =
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

    ButtonStyle registerPolicyButton = ElevatedButton.styleFrom(
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
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: goBackButtonStyle,
                  child: const Icon(Icons.arrow_back),
                ),
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
                  future:
                      servicesRestPoliza.obtenerPolizasDeUsuario(widget.token),
                  builder: ((context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          Poliza poliza = snapshot.data!.elementAt(index);
                          _logger.i(poliza.fechaInicio);
                          SizedBox space = SizedBox(
                            height: responsive.hp(2.5),
                          );
                          ReportCardContent card = ReportCardContent(
                            constraints: BoxConstraints(
                              maxWidth: responsive.dp(65),
                              minHeight: responsive.hp(18),
                            ),
                            child: createCardContentPoliza(poliza, context),
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
              SizedBox(
                height: responsive.hp(10),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          FormInsurancePolicyPage(token: widget.token),
                    ),
                  );
                },
                style: registerPolicyButton,
                child: Text(
                  "Comprar nueva póliza",
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

Widget createCardContentPoliza(Poliza poliza, BuildContext context) {
  Responsive responsive = Responsive(context);
  String fechaRegistro = DateFormat('dd/MM/yyyy').format(poliza.fechaInicio);
  String vigencia = DateFormat('dd/MM/yyyy').format(poliza.fechaFin);
  String tipoCobertura = poliza.tipoCobertura;
  String costo = poliza.costo.toString();

  TextStyle polizaInfoStyle =
      TextStyle(fontSize: responsive.dp(1.2), color: Colors.black);
  TextStyle polizaHintStyle = TextStyle(
    fontSize: responsive.dp(1.2),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  return Row(
    children: <Widget>[
      SizedBox(
        width: responsive.dp(1.4),
      ),
      SizedBox(
        child: Text(
          "Fecha de registro:",
          style: polizaHintStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(.2),
      ),
      SizedBox(
        child: Text(
          fechaRegistro,
          style: polizaInfoStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(1.4),
      ),
      SizedBox(
        child: Text(
          "Fecha de vencimiento:",
          style: polizaHintStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(.2),
      ),
      SizedBox(
        child: Text(
          vigencia,
          style: polizaInfoStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(1.4),
      ),
      SizedBox(
        child: Text(
          "Tipo de cobertura:",
          style: polizaHintStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(.2),
      ),
      SizedBox(
        child: Text(
          tipoCobertura,
          style: polizaInfoStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(1.4),
      ),
      SizedBox(
        child: Text(
          "Costo:",
          style: polizaHintStyle,
        ),
      ),
      SizedBox(
        width: responsive.dp(.2),
      ),
      SizedBox(
        child: Text(
          costo,
          style: polizaInfoStyle,
        ),
      ),
    ],
  );
}

String consultarVehiculo() {
  return consultarVehiculo();
}
