class Pago {
  int idPago;
  int idPoliza;
  int idConductor;
  int monto;
  DateTime fecha;
  bool formaDePago;
  String numeroDeTarjeta;
  String fechaVencimiento;
  String cvv;

  Pago({
    
      required this.idPago,
      required this.idPoliza,
      required this.idConductor,
      required this.monto,
      required this.fecha,
      required this.formaDePago,
      required this.numeroDeTarjeta,
      required this.fechaVencimiento,
      required this.cvv
  });

  int get getIdPago => idPago;
  int get getIdPoliza => idPoliza;
  int get getIdConductor => idConductor;
  int get getMonto => monto;
  DateTime get getFecha => fecha;
  bool get getFormaDePago => formaDePago;
  String get getNumeroDeTarjeta => numeroDeTarjeta;
  String get getFechaVencimiento => fechaVencimiento;
  String get getCvv => cvv;

  set setIdPago(int idPago) {
    this.idPago = idPago;
  }

  set setIdPoliza(int idPoliza) {
    this.idPoliza = idPoliza;
  }

  set setIdConductor(int idConductor) {
    this.idConductor = idConductor;
  }

  set setMonto(int monto) {
    this.monto = monto;
  }

  set setFecha(DateTime fecha) {
    this.fecha = fecha;
  }

  set setFormaDePago(bool formaDePago) {
    this.formaDePago = formaDePago;
  }

  set setNumeroDeTarjeta(String numeroDeTarjeta) {
    this.numeroDeTarjeta = numeroDeTarjeta;
  }

  set setFechaVencimiento(String fechaVencimiento) {
    this.fechaVencimiento = fechaVencimiento;
  }

  set setCvv(String cvv) {
    this.cvv = cvv;
  }

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
      idPago: json["idVehiculo"],
      idPoliza: json["idpoliza"],
      idConductor: json["idConductor"],
      monto: json["monto"],
      fecha: DateTime.parse(json["fecha"]),
      formaDePago: json["formaDePago"],
      numeroDeTarjeta: json["numeroDeTarjeta"],
      fechaVencimiento: json["fechaVencimiento"],
      cvv: json["cvv"],
  );

  Map<String, dynamic> toJson() => {
      "idPago": idPago,
      "idpoliza": idPoliza,
      "idConductor": idConductor,
      "monto": monto,
      "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
      "formaDePago": formaDePago,
      "numeroDeTarjeta": numeroDeTarjeta,
      "fechaVencimiento": fechaVencimiento,
      "cvv": cvv
  };
}