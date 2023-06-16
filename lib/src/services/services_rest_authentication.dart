import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
//import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

class ServicesRestAuthentication{
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<String> validarSesionConductor(Conductor conductor) async{
    final respuesta = await _dio.post(
      "${urlApi}autenticacion/conductor",
      options: Options(
        headers: {'Content-type' : 'application/json'},
      ),
      data: {
        "idconductor": conductor.getIdConductor(),
        "nombreCompleto": conductor.getNombreCompleto(),
        "numLicencia": conductor.getNumLicencia(),
        "fechaNacimiento": conductor.getFechaNacimiento(),
        "telefono": conductor.getTelefono(),
        "contrasena": conductor.getContrasena()
      }
    );

    _logger.i(respuesta.data);

    String jwtToken = respuesta.data.toString();
    return jwtToken;
  }

  Future<String> validarSesionEmpleado(Empleado empleado) async{
    final respuesta = await _dio.post(
      "${urlApi}autenticacion/empleado",
      options: Options(
        headers: {'Content-type' : 'application/json'},
      ),
      data: {
        "idEmpleado": empleado.getIdEmpleado(),
        "nombreCompleto": empleado.getNombreCompleto(),
        "fechaIngreso": empleado.getFechaIngreso(),
        "cargo": empleado.getCargo(),
        "nombreUsuario": empleado.getNombreUsuario(),
        "contrasena": empleado.getContrasena()
      }
    );

    _logger.i(respuesta.data);

    String jwtToken = respuesta.data.toString();
    return jwtToken;
  }

}