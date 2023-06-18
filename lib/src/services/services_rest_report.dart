import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/reporte_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';
import 'package:gesive_web_app/src/services/services_rest_employee.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';

class ServicesRestReporte {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Reporte convertirReporte(String reporteJson) {
    Map<String, dynamic> jsonConvertido = jsonDecode(reporteJson);
    return Reporte.fromJson(jsonConvertido);
  }

  List<Reporte> convertirReportes(String cuerpoRespuesta) {
    var convertido = json.decode(cuerpoRespuesta).cast<Map<String, dynamic>>();
    return convertido.map<Reporte>((json) => Reporte.fromJson(json)).toList();
  }

  Future<List<Reporte>> obtenerReportes() async {
    final respuesta = await _dio.get(
      "${urlApi}reportes",
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (respuesta.statusCode == 200) {
      return (respuesta.data as List).map((e) => Reporte.fromJson(e)).toList();
    } else {
      throw Exception("No se pudieron recuperar los reportes");
    }
  }

  Future<List<Reporte>> reportesAjustador(String username, String token) {
    ServicesRestEmpleado sre = ServicesRestEmpleado();
    Empleado empleado = sre.obtenerEmpleadoByUsername(username, token) as Empleado;

    Future<List<Reporte>> reportes = obtenerReportesAjustador(empleado.idEmpleado, token);
    return reportes;
  }


  Future<List<Reporte>> obtenerReportesAjustador(int idAjustador, String token) async {
    final respuesta = await _dio.get(
      "${urlApi}reportes/ajustadorAsignado?id_ajustador=$idAjustador",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    if (respuesta.statusCode == 200) {
      return (respuesta.data as List).map((e) => Reporte.fromJson(e)).toList();
    } else {
      throw Exception("No se pudieron recuperar los reportes");
    }
  }
}
