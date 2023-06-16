import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZEVtcGxlYWRvIjowLCJub21"
    "icmVDb21wbGV0byI6InN0cmluZyIsImZlY2hhSW5ncmVzbyI6InN0cmluZyIsImNhcmdvIjoic3RyaW"
    "5nIiwibm9tYnJlVXN1YXJpbyI6ImNhemFGdXJyb3M5MDQ1IiwiY29udHJhc2VuYSI6IkhBTE9jZWEyMD"
    "YtIiwiZXhwIjoxNjg2ODg0NTY2fQ.KPcdV5ryI6UyfyMuea-6EQvsPDENVaIb8KwmRq2a4UA";

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
          headers: {'Content-Type': 'application/json'},
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
}
