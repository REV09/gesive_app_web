import 'package:flutter_test/flutter_test.dart';
import 'package:gesive_web_app/src/services/services_rest_report.dart';

void main() {
  test('Prueba de obtener reportes', () async {
    String token = "";
    ServicesRestReporte servicesRestReporte = ServicesRestReporte();
    var reportes = await servicesRestReporte.obtenerReportes(token);
    expect(reportes.length, 1);
  });

  // test('Prueba de registrar reporte', () async {
  //   ServicesRestReporte servicesRestReporte = ServicesRestReporte();
  //   var respuesta = await servicesRestReporte.registrarReporte(1, 1, 1, 1, 1,
  //       "Prueba", "Prueba", "Prueba", "Prueba", "Prueba", "Prueba");
  //   expect(respuesta, 200);
  // });
}
