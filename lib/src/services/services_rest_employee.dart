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
      throw Exception("No se pudieron recuperar los empleados");
    }
  }

  Future<int> registrarEmpleado(Empleado empleado) async {
    String dateFormat = "${empleado.fechaIngreso.year}"
        "-${empleado.fechaIngreso.month}"
        "-${empleado.fechaIngreso.day}";
    final respuesta = await _dio.post("${urlApi}empleado",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "idEmpleado": empleado.getIdEmpleado(),
          "nombreCompleto": empleado.getNombreCompleto(),
          "fechaIngreso": dateFormat,
          "cargo": empleado.getCargo(),
          "nombreUsuario": empleado.getNombreUsuario(),
          "contrasena": empleado.getContrasena()
        });

    logger.i(respuesta.statusCode);

    return respuesta.statusCode!;
  }
}
