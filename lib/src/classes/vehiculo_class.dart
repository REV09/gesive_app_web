class Vehiculo {
  int idvehiculo;
  String numeroSerie;
  int anio;
  String marca;
  String modelo;
  String color;
  String numPlacas;

  Vehiculo({
    this.idvehiculo = 0,
    required this.numeroSerie,
    required this.anio,
    required this.marca,
    required this.modelo,
    required this.color,
    required this.numPlacas,
  });

  void setIdVehiculo(int id) {
    idvehiculo = id;
  }

  void setNumeroSerie(String numeroSerie) {
    this.numeroSerie = numeroSerie;
  }

  void setAnio(int anio) {
    this.anio = anio;
  }

  void setMarca(String marca) {
    this.marca = marca;
  }

  void setModelo(String modelo) {
    this.modelo = modelo;
  }

  void setColor(String color) {
    this.color = color;
  }

  void setNumPlacas(String numPlacas) {
    this.numPlacas = numPlacas;
  }

  int getIdVehiculo() => idvehiculo;
  String getNumeroSerie() => numeroSerie;
  int getAnio() => anio;
  String getMarca() => marca;
  String getModelo() => modelo;
  String getColor() => color;
  String getNumPlacas() => numPlacas;

  factory Vehiculo.fromJson(Map<String, dynamic> json) => Vehiculo(
        idvehiculo: json["idvehiculo"],
        numeroSerie: json["numeroSerie"],
        anio: json["anio"],
        marca: json["marca"],
        modelo: json["modelo"],
        color: json["color"],
        numPlacas: json["numPlacas"],
      );

  Map<String, dynamic> toJson() => {
        "idvehiculo": idvehiculo,
        "numeroSerie": numeroSerie,
        "anio": anio,
        "marca": marca,
        "modelo": modelo,
        "color": color,
        "numPlacas": numPlacas,
      };
}
