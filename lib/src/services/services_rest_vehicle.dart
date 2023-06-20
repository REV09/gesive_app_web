import 'package:dio/dio.dart';
import 'package:gesive_web_app/src/classes/vehiculo_class.dart';
import 'package:gesive_web_app/src/services/api_configuraciones.dart';
import 'package:gesive_web_app/src/services/services_rest_authentication.dart';
import 'package:logger/logger.dart';

import '../classes/conductor_clase.dart';

class ServicesRestVehicle {
  final Dio _dio = Dio();
  final Logger _logger = Logger();
  ServicesRestAuthentication _servicesRestAuthentication =
      ServicesRestAuthentication();

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
        "idConductor": vehiculo.getIdConductor(),
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

  Future<List<Vehiculo>> obtenerListaVehiculos(String token) async {
    Conductor conductor =
        await _servicesRestAuthentication.validarTokenConductor(token);
    int id = conductor.getIdConductor();
    final respuesta = await _dio.get(
      "${urlApi}vehiculos/conductor?id_conductor=$id",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ),
    );

    if (respuesta.statusCode == 200) {
      List<dynamic> datos = respuesta.data;
      List<Vehiculo> listaVehiculos =
          datos.map((json) => Vehiculo.fromJson(json)).toList();
      return listaVehiculos;
    } else {
      throw Exception("No se pudo recuperar la lista de vehículos");
    }
  }
}
