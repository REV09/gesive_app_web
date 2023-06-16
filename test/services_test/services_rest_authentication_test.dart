import 'package:flutter_test/flutter_test.dart';
import 'package:gesive_web_app/src/classes/conductor_clase.dart';
import 'package:gesive_web_app/src/classes/empleado_class.dart';
import 'package:gesive_web_app/src/services/services_rest_authentication.dart';

void main(){
  test("Autenticar empleado", () async {
    ServicesRestAuthentication
    servicesRestAuthentication = ServicesRestAuthentication();

    var empleado = Empleado.inicioSesion(
        nombreUsuario: "cazaFurros9045",
        contrasena: "HALOcea206-"
    );

    String jwt =
    await servicesRestAuthentication.validarSesionEmpleado(empleado);
    bool validJwt = false;
    if(jwt.isNotEmpty){
      validJwt = true;
    }
    expect(validJwt, true);
  });

  test("Autenticar conductor", () async {
    ServicesRestAuthentication
    servicesRestAuthentication = ServicesRestAuthentication();
    var conductor = Conductor.inicioSesion(
        telefono: "2281024226",
        contrasena: "SonrisaC1-"
    );

    String jwt =
    await servicesRestAuthentication.validarSesionConductor(conductor);

    expect(jwt, isNotNull);
  });

  test("Validar Token de empleado", () async {
    ServicesRestAuthentication
    servicesRestAuthentication =  ServicesRestAuthentication();
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZEVtcGxlYWRvIjoxLC"
        "Jub21icmVDb21wbGV0byI6IkhlY3RvciBEYXZpZCBNYWRyaWQgUml2ZXJhIiwiZmVjaGFJ"
        "bmdyZXNvIjoiMjAxOC0wOS0yNyIsImNhcmdvIjoiQWp1c3RhZG9yIiwibm9tYnJlVXN1YX"
        "JpbyI6ImNhemFGdXJyb3M5MDQ1IiwiY29udHJhc2VuYSI6IkhBTE9jZWEyMDYtIiwiZXhw"
        "IjoxNjg2OTg2MTk5fQ.AYNMEGT5qjYx84V4ZVZCen_Sp4jiwE9FoFJa6wuFSr0";
    Empleado empleadoObtenido =
    await servicesRestAuthentication.validarTokenEmpleado(token);
    expect(empleadoObtenido, isNotNull);
  });

  test("Validar token de conductor", () async {
    ServicesRestAuthentication
    servicesRestAuthentication =  ServicesRestAuthentication();
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGNvbmR1Y3RvciI6My"
        "wibm9tYnJlQ29tcGxldG8iOiJNaXJpYW0gTW9uc2VycmF0IEJlbml0ZXogU2FsYXphciIs"
        "Im51bUxpY2VuY2lhIjoiQUJDREUxMjM0IiwiZmVjaGFOYWNpbWllbnRvIjoiMjAwMS0wNC"
        "0zMCIsInRlbGVmb25vIjoiMjI4MTAyNDIyNiIsImNvbnRyYXNlbmEiOiJTb25yaXNhQzEt"
        "IiwiZXhwIjoxNjg2OTg3MTUxfQ.gzKuMnR0vmRW5J0gWw6IObh2mhj_MfYZTOofpf2JCnc";
    Conductor empleadoObtenido =
    await servicesRestAuthentication.validarTokenConductor(token);
    expect(empleadoObtenido, isNotNull);
  });

}