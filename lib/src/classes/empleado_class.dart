import 'package:gesive_web_app/src/utils/globals.dart';

class Empleado {
  int idEmpleado;
  String nombreCompleto;
  String fechaIngreso = "2023-01-01";
  String cargo;
  String nombreUsuario;
  String contrasena;

  Empleado({
    required this.idEmpleado,
    required this.nombreCompleto,
    required this.fechaIngreso,
    required this.cargo,
    required this.nombreUsuario,
    required this.contrasena,
  });

  Empleado.inicioSesion({
    this.idEmpleado = 0,
    this.nombreCompleto = "empty",
    this.cargo = "empty",
    required this.nombreUsuario,
    required this.contrasena,
  });

  void setIdEmpleado(int id) {
    idEmpleado = id;
  }

  void setNombreCompleto(String nombre) {
    nombreCompleto = nombre;
  }

  void setFechaIngreso(String fecha) {
    fechaIngreso = fecha;
  }

  void setCargo(String cargo) {
    this.cargo = cargo;
  }

  void setNombreUsuario(String nombreUsuario) {
    this.nombreUsuario = nombreUsuario;
  }

  void setContrasena(String contrasena) {
    this.contrasena = contrasena;
  }

  int getIdEmpleado() => idEmpleado;
  String getNombreCompleto() => nombreCompleto;
  String getFechaIngreso() => fechaIngreso;
  String getCargo() => cargo;
  String getNombreUsuario() => nombreUsuario;
  String getContrasena() => contrasena;

  factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
        idEmpleado: json["idEmpleado"],
        nombreCompleto: json["nombreCompleto"],
        fechaIngreso: json["fechaIngreso"],
        cargo: json["cargo"],
        nombreUsuario: json["nombreUsuario"],
        contrasena: json["contrasena"],
      );

  Map<String, dynamic> toJson() => {
        "idEmpleado": idEmpleado,
        "nombreCompleto": nombreCompleto,
        "fechaIngreso": fechaIngreso,
        "cargo": cargo,
        "nombreUsuario": nombreUsuario,
        "contrasena": contrasena,
      };
}
