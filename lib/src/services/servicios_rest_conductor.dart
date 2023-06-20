import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

class ServiceRestConductor {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<int> autenticateLogin(Conductor conductor) async {
    final respuesta = await _dio.post(
      "${urlApi}authConductor",
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: {
        "idconductor": conductor.getIdConductor(),
        "nombreCompleto": conductor.getNombreCompleto(),
        "numLicencia": conductor.getNumLicencia(),
        "fechaNacimiento": conductor.getFechaNacimiento(),
        "telefono": conductor.getTelefono(),
        "contrasena": conductor.getContrasena()
      },
    );

    _logger.i(respuesta.statusCode);

    int codigoRespuesta = respuesta.statusCode!;
    return codigoRespuesta;
  }

  Future<int> registrarConductor(Conductor conductor) async {
    final respuesta = await _dio.post("${urlApi}conductor",
        options: Options(
          headers: {'Content-type': 'application/json'},
        ),
        data: {
          "idconductor": conductor.getIdConductor(),
          "nombreCompleto": conductor.getNombreCompleto(),
          "numLicencia": conductor.getNumLicencia(),
          "fechaNacimiento": conductor.getFechaNacimiento(),
          "telefono": conductor.getTelefono(),
          "contrasena": conductor.getContrasena()
        });

    _logger.i(respuesta.statusCode);

    return respuesta.statusCode!;
  }

  Future<Conductor> obtenerConductorByPhone(
      String telefono, String token) async {
    final respuesta = await _dio.get(
      "${urlApi}conductor/telefono?numero_telefono=$telefono",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    if (respuesta.statusCode == 200) {
      return Conductor.fromJson(respuesta.data);
    } else {
      throw Exception("No se pudo recuperar el conductor");
    }
  }

  Future<Conductor> obtenerConductorByID(int idConductor, String token) async {
    final respuesta = await _dio.get(
      "${urlApi}conductor?id_conductor=$idConductor",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    if (respuesta.statusCode == 200) {
      return Conductor.fromJson(respuesta.data);
    } else {
      throw Exception("No se pudo recuperar el conductor");
    }
  }
}
