import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/pago_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

import '../classes/poliza_class.dart';

class ServicesRestPago{
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<int> registrarPago(Pago pago, String token) async {
    final respuesta = await _dio.post("${urlApi}pago",
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer $token"},
        ),
        data: {
          "idPago": pago.getIdPago,
          "idPoliza": pago.getIdPoliza,
          "idConductor": pago.getIdConductor,
          "monto": pago.getMonto,
          "fecha": pago.getFecha,
          "formaDePago": pago.getFormaDePago,
          "numeroTarjeta": pago.numeroDeTarjeta,
          "fechaVencimiento": pago.fechaVencimiento,
          "cvv": pago.getCvv
        });

    _logger.i(respuesta.statusCode);

    return respuesta.statusCode!;
  }
}
