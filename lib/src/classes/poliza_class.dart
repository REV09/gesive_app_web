class Poliza {
  int idPoliza;
  int idConductor;
  int idVehiculo;
  DateTime fechaInicio;
  DateTime fechaFin;
  int plazo;
  String tipoCobertura;
  int costo;

  Poliza(
      {required this.idPoliza,
      required this.idConductor,
      required this.idVehiculo,
      required this.fechaInicio,
      required this.fechaFin,
      required this.plazo,
      required this.tipoCobertura,
      required this.costo});

  factory Poliza.fromJson(Map<String, dynamic> json) => Poliza(
        idPoliza: json["idpoliza"],
        idConductor: json["idConductor"],
        idVehiculo: json["idVehiculo"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        plazo: json["plazo"],
        tipoCobertura: json["tipoCobertura"],
        costo: json["costo"],
      );

  int getIdPoliza() => idPoliza;
  int getIdConductor() => idConductor;
  int getIdVehiculo() => idVehiculo;
  DateTime getFechaInicio() => fechaInicio;
  DateTime getFechaFin() => fechaFin;
  int getPlazo() => plazo;
  String getTipoCobertura() => tipoCobertura;
  int getCosto() => costo;

  Map<String, dynamic> toJson() => {
        "idpoliza": idPoliza,
        "idConductor": idConductor,
        "idVehiculo": idVehiculo,
        "fechaInicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fechaFin":
            "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "plazo": plazo,
        "tipoCobertura": tipoCobertura,
        "costo": costo,
      };
}
