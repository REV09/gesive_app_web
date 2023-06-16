class Conductor {
  int idConductor;
  String nombreCompleto;
  String numLicencia;
  String fechaNacimiento = "2023-01-01";
  String telefono;
  String contrasena;

  Conductor(
      {this.idConductor = 0,
      required this.nombreCompleto,
      required this.numLicencia,
      required this.fechaNacimiento,
      required this.telefono,
      required this.contrasena});

  Conductor.inicioSesion(
      {this.idConductor = 0,
      this.nombreCompleto = "empty",
      this.numLicencia = "123456",
      required this.telefono,
      required this.contrasena});

  void setIdConductor(int id) {
    idConductor = id;
  }

  void setNombreCompleto(String nombreCompleto) {
    nombreCompleto = nombreCompleto;
  }

  void setNumLicencia(String numeroLicencia) {
    numLicencia = numeroLicencia;
  }

  void setFechaNacimiento(String fecha) {
    fechaNacimiento = fecha;
  }

  void setTelefono(String telefono) {
    telefono = telefono;
  }

  void setContrasena(String contrasena) {
    contrasena = contrasena;
  }

  int getIdConductor() => idConductor;
  String getNombreCompleto() => nombreCompleto;
  String getNumLicencia() => numLicencia;
  String getFechaNacimiento() => fechaNacimiento;
  String getTelefono() => telefono;
  String getContrasena() => contrasena;
}
