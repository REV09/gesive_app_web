import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

class ServiceRestConductor {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<int> autenticateLogin(Conductor conductor) async {
    String dateFormat = "${conductor.fechaNacimiento.year}"
        "-${conductor.fechaNacimiento.month}"
        "-${conductor.fechaNacimiento.day}";
    final respuesta = await _dio.post(
      "${urlApi}authConductor",
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: {
        "idconductor": conductor.getIdConductor(),
        "nombreCompleto": conductor.getNombreCompleto(),
        "numLicencia": conductor.getNumLicencia(),
        "fechaNacimiento": dateFormat,
        "telefono": conductor.getTelefono(),
        "contrasena": conductor.getContrasena()
      },
    );

    _logger.i(respuesta.statusCode);

    int codigoRespuesta = respuesta.statusCode!;
    return codigoRespuesta;
  }

  Future<int> registrarConductor(Conductor conductor) async {
    String dateFormat = "${conductor.fechaNacimiento.year}"
        "-${conductor.fechaNacimiento.month}"
        "-${conductor.fechaNacimiento.day}";
    final respuesta = await _dio.post("${urlApi}conductor",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "idconductor": conductor.getIdConductor(),
          "nombreCompleto": conductor.getNombreCompleto(),
          "numLicencia": conductor.getNumLicencia(),
          "fechaNacimiento": dateFormat,
          "telefono": conductor.getTelefono(),
          "contrasena": conductor.getContrasena()
        });

    _logger.i(respuesta.statusCode);

    return respuesta.statusCode!;
  }
}
