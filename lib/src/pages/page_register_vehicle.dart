import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../widgets/register_vehicle_form.dart';

class RegisterVehiclePage extends StatefulWidget {
  String token;
  String sesion;
  String user;
  RegisterVehiclePage({
    required this.token,
    required this.sesion,
    required this.user,
  });

  static const routeName = "registerVehicle";
  @override
  _RegisterVehiclePage createState() => _RegisterVehiclePage();
}

class _RegisterVehiclePage extends State<RegisterVehiclePage> {
  @override
  Widget build(BuildContext context) {
    const String textRegister = "Crear nueva cuenta";
    Responsive responsive = Responsive(context);
    final TextStyle textRegisterStyle =
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: responsive.dp(3),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: goBackButtonStyle,
                child: const Icon(Icons.arrow_back),
              ),
              SizedBox(
                width: responsive.dp(3),
              ),
              Text(
                textRegister,
                textAlign: TextAlign.center,
                style: textRegisterStyle,
              ),
              SizedBox(
                width: responsive.dp(3),
              ),
              RegisterVehicleForm(
                token: widget.token,
              )
            ],
          ),
        ),
      ),
    );
  }
}
