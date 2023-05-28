class Reporte {
  int idReporte;
  int idPoliza;
  double posicionLat;
  double posicionLon;
  String involucradosNombres;
  String involucradosVehiculos;
  int fotos;
  int idAjustador;
  String estatus;
  String dictamenTexto;
  String dictamenHora;
  DateTime dictamenFecha;
  String dictamenFolio;

  Reporte({
    this.idReporte = 0,
    required this.idPoliza,
    required this.posicionLat,
    required this.posicionLon,
    required this.involucradosNombres,
    required this.involucradosVehiculos,
    required this.fotos,
    required this.idAjustador,
    required this.estatus,
    required this.dictamenTexto,
    required this.dictamenHora,
    required this.dictamenFecha,
    required this.dictamenFolio,
  });

  void setIdReporte(int idreporte) {
    idReporte = idreporte;
  }

  void setIdPoliza(int idpoliza) {
    idPoliza = idpoliza;
  }

  void setPosicionLat(double posicionlat) {
    posicionLat = posicionlat;
  }

  void setPosicionLon(double posicionLon) {
    posicionLon = posicionLon;
  }

  void setInvolucradosNombres(String involucrados) {
    involucradosNombres = involucrados;
  }

  void setInvolucradosVehiculos(String involucrados) {
    involucradosVehiculos = involucrados;
  }

  void setFotos(int fotos) {
    fotos = fotos;
  }

  void setIdAjustador(int idajustador) {
    idAjustador = idajustador;
  }

  void setEstatus(String estatus) {
    estatus = estatus;
  }

  void setDictamenTexto(String dictamen) {
    dictamenTexto = dictamen;
  }

  void setDictamenHora(String hora) {
    dictamenHora = hora;
  }

  void setDictamenFecha(DateTime fecha) {
    dictamenFecha = fecha;
  }

  void setDictamenFolio(String folio) {
    dictamenFolio = folio;
  }

  int getIdReporte() => idReporte;
  int getIdPoliza() => idPoliza;
  double getPosicionLat() => posicionLat;
  double getPosicionLon() => posicionLon;
  String getInvolucradosNombres() => involucradosNombres;
  String getInvolucradosVehiculos() => involucradosVehiculos;
  int getFotos() => fotos;
  int getIdAjustador() => idAjustador;
  String getEstatus() => estatus;
  String getDictamenTexto() => dictamenTexto;
  String getDictamenHora() => dictamenHora;
  DateTime getDictamenFecha() => dictamenFecha;
  String getDictamenFolio() => dictamenFolio;

  factory Reporte.fromJson(Map<String, dynamic> json) => Reporte(
        idReporte: json["idReporte"],
        idPoliza: json["idPoliza"],
        posicionLat: json["posicionLat"]?.toDouble(),
        posicionLon: json["posicionLon"]?.toDouble(),
        involucradosNombres: json["involucradosNombres"],
        involucradosVehiculos: json["involucradosVehiculos"],
        fotos: json["fotos"],
        idAjustador: json["idAjustador"],
        estatus: json["estatus"],
        dictamenTexto: json["dictamenTexto"],
        dictamenFecha: DateTime.parse(json["dictamenFecha"]),
        dictamenHora: json["dictamenHora"],
        dictamenFolio: json["dictamenFolio"],
      );

  Map<String, dynamic> toJson() => {
        "idReporte": idReporte,
        "idPoliza": idPoliza,
        "posicionLat": posicionLat,
        "posicionLon": posicionLon,
        "involucradosNombres": involucradosNombres,
        "involucradosVehiculos": involucradosVehiculos,
        "fotos": fotos,
        "idAjustador": idAjustador,
        "estatus": estatus,
        "dictamenTexto": dictamenTexto,
        "dictamenFecha":
            "${dictamenFecha.year.toString().padLeft(4, '0')}-${dictamenFecha.month.toString().padLeft(2, '0')}-${dictamenFecha.day.toString().padLeft(2, '0')}",
        "dictamenHora": dictamenHora,
        "dictamenFolio": dictamenFolio,
      };
}
