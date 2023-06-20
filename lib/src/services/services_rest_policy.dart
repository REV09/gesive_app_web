import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

import '../classes/poliza_class.dart';

class ServicesRestPoliza {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  /*Reporte convertirPoliza(String reporteJson) {
    Map<String, dynamic> jsonConvertido = jsonDecode(reporteJson);
    return Reporte.fromJson(jsonConvertido);
  }

  List<Reporte> convertirPolizas(String cuerpoRespuesta) {
    var convertido = json.decode(cuerpoRespuesta).cast<Map<String, dynamic>>();
    return convertido.map<Reporte>((json) => Reporte.fromJson(json)).toList();
  }*/

  Future<List<Poliza>> obtenerPolizas(String token) async {
    final respuesta = await _dio.get(
      "${urlApi}polizas",
      options: Options(
        headers: {'Content-Type': 'application/json',
                  'Authorization': "Bearer $token"
                  },
      ),
    );

    if (respuesta.statusCode == 200) {
      return (respuesta.data as List).map((e) => Poliza.fromJson(e)).toList();
    } else {
      throw Exception("No se pudieron recuperar las polizas");
    }
  }

  Future<List<Poliza>> obtenerPolizasUsuario(int id, String token) async {
    final respuesta = await _dio.get(
      "${urlApi}polizas/usuario?id_conductor=$id",
      options: Options(
        headers: {'Content-Type': 'application/json',
                  'Authorization': "Bearer $token"
                  },
      ),
    );

    if (respuesta.statusCode == 200) {
      return (respuesta.data as List).map((e) => Poliza.fromJson(e)).toList();
    } else {
      throw Exception("No se pudieron recuperar las polizas");
    }
  }

  Future<Poliza> obtenerPoliza(int idPoliza, String token) async {
    final respuesta = await _dio.get(
      "${urlApi}poliza?id_poliza=$idPoliza",
      options: Options(
        headers: {'Content-Type': 'application/json',
                  'Authorization': "Bearer $token"
                  },
      ),
    );

    if (respuesta.statusCode == 200) {
      return Poliza.fromJson(respuesta.data);
    } else {
      throw Exception("No se pudo recuperar la poliza");
    }
  }
}
