import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/vehiculo_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:logger/logger.dart';

class ServicesRestVehicle {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<int> registrarVehiculo(Vehiculo vehiculo, String token) async {
    final respuesta = await _dio.post(
      "${urlApi}vehiculo",
      options: Options(
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
      data: {
        "idvehiculo": vehiculo.getIdVehiculo(),
        "numeroSerie": vehiculo.getNumeroSerie(),
        "anio": vehiculo.getAnio(),
        "marca": vehiculo.getMarca(),
        "modelo": vehiculo.getModelo(),
        "color": vehiculo.getColor(),
        "numPlacas": vehiculo.getNumPlacas(),
      },
    );

    _logger.i(respuesta.statusCode);

    int codigoRespuesta = respuesta.statusCode!;
    return codigoRespuesta;
  }

  Future<Vehiculo> obtenerVehiculo(int id, String token) async {
    final respuesta = await _dio.get(
      "${urlApi}vehiculo?id_vehiculo=$id",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    if (respuesta.statusCode == 200) {
      return Vehiculo.fromJson(respuesta.data);
    } else {
      throw Exception("No se pudo recuperar el empleado");
    }
  }
}