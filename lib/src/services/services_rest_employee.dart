import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZEVtcGxlYWRvIjowLCJub21"
    "icmVDb21wbGV0byI6InN0cmluZyIsImZlY2hhSW5ncmVzbyI6InN0cmluZyIsImNhcmdvIjoic3RyaW"
    "5nIiwibm9tYnJlVXN1YXJpbyI6ImNhemFGdXJyb3M5MDQ1IiwiY29udHJhc2VuYSI6IkhBTE9jZWEyMD"
    "YtIiwiZXhwIjoxNjg2ODg0NTY2fQ.KPcdV5ryI6UyfyMuea-6EQvsPDENVaIb8KwmRq2a4UA";

class ServicesRestEmpleado {
  final Dio _dio = Dio();
  final Logger logger = Logger();

  Future<List<Empleado>> obtenerEmpleados() async {
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

  Future<int> registrarEmpleado(Empleado empleado) async {
    final respuesta = await _dio.post("${urlApi}empleado",
        options: Options(
          headers: {'Content-Type': 'application/json', 'Authorization': token},
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
}
