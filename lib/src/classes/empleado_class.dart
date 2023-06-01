class Empleado {
  int idEmpleado;
  String nombreCompleto;
  DateTime fechaIngreso = DateTime.now();
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
    this.cargo = "Empty",
    required this.nombreUsuario,
    required this.contrasena,
  });

  void setIdEmpleado(int id) {
    idEmpleado = id;
  }

  void setNombreCompleto(String nombre) {
    nombreCompleto = nombre;
  }

  void setFechaIngreso(DateTime fecha) {
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
  DateTime getFechaIngreso() => fechaIngreso;
  String getCargo() => cargo;
  String getNombreUsuario() => nombreUsuario;
  String getContrasena() => contrasena;

  factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
        idEmpleado: json["idEmpleado"],
        nombreCompleto: json["nombreCompleto"],
        fechaIngreso: DateTime.parse(json["fechaIngreso"]),
        cargo: json["cargo"],
        nombreUsuario: json["nombreUsuario"],
        contrasena: json["contrasena"],
      );

  Map<String, dynamic> toJson() => {
        "idEmpleado": idEmpleado,
        "nombreCompleto": nombreCompleto,
        "fechaIngreso":
            "${fechaIngreso.year.toString().padLeft(4, '0')}-${fechaIngreso.month.toString().padLeft(2, '0')}-${fechaIngreso.day.toString().padLeft(2, '0')}",
        "cargo": cargo,
        "nombreUsuario": nombreUsuario,
        "contrasena": contrasena,
      };
}
