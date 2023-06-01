import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

class ServicesRestEmpleado {
  final Dio _dio = Dio();
  final Logger logger = Logger();

  Future<List<Empleado>> obtenerEmpleados() async {
    final respuesta = await _dio.get(
      "${urlApi}empleados",
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (respuesta.statusCode == 200) {
      return (respuesta.data as List).map((e) => Empleado.fromJson(e)).toList();
    } else {
      throw Exception("No se pudieron recuperar los reportes");
    }
  }
}
