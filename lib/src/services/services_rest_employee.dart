import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

class ServicesRestEmpleado {
  final Dio _dio = Dio();
  final Logger logger = Logger();

  Future<List<Empleado>> obtenerEmpleados(String token) async {
    final respuesta = await _dio.get(
      "${urlApi}empleados",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    if (respuesta.statusCode == 200) {
      return (respuesta.data as List).map((e) => Empleado.fromJson(e)).toList();
    } else {
      throw Exception("No se pudieron recuperar los empleados");
    }
  }

  Future<int> registrarEmpleado(Empleado empleado, String token) async {
    final respuesta = await _dio.post("${urlApi}empleado",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token"
          },
        ),
        data: {
          "idEmpleado": empleado.getIdEmpleado(),
          "nombreCompleto": empleado.getNombreCompleto(),
          "fechaIngreso": empleado.getFechaIngreso(),
          "cargo": empleado.getCargo(),
          "nombreUsuario": empleado.getNombreUsuario(),
          "contrasena": empleado.getContrasena()
        });

    logger.i(respuesta.statusCode);

    return respuesta.statusCode!;
  }

  Future<int> eliminarEmpleado(int idEmpleado, String token) async {
    final respuesta = await _dio.delete(
      "${urlApi}empleado?id_empleado=$idEmpleado",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    return respuesta.statusCode!;
  }
}
