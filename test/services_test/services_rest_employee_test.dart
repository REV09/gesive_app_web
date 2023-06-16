import 'package:flutter_test/flutter_test.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/services/services_rest_employee.dart';
import 'package:intl/intl.dart';

void main() {
  test('Prueba de obtener empleados', () async {
    ServicesRestEmpleado servicesRestEmpleado = ServicesRestEmpleado();
    var empleados = await servicesRestEmpleado.obtenerEmpleados();
    expect(empleados.length, 1);
  });

  test('Prueba de registrar empleado', () async {
    ServicesRestEmpleado servicesRestEmpleado = ServicesRestEmpleado();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime date = DateTime.now();
    var empleado = Empleado(
        idEmpleado: 1,
        nombreCompleto: "Prueba",
        fechaIngreso: formatter.format(date),
        cargo: "Prueba",
        nombreUsuario: "Prueba",
        contrasena: "Prueba");
    var respuesta = await servicesRestEmpleado.registrarEmpleado(empleado);
    expect(respuesta, 200);
  });
}
