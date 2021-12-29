import 'dart:convert';

class ResourceResponse {
  ResourceResponse({
    required this.id,
    required this.nombreRecurso,
    required this.cantidadExistente,
    required this.cantidadDisponible,
    required this.tipoid,
    this.imagen,
  });

  String id;
  String nombreRecurso;
  int cantidadExistente;
  int cantidadDisponible;
  String tipoid;
  String? imagen;

  factory ResourceResponse.fromJson(String str) =>
      ResourceResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResourceResponse.fromMap(Map<String, dynamic> json) =>
      ResourceResponse(
        id: json["id"],
        nombreRecurso: json["nombreRecurso"],
        cantidadExistente: json["cantidadExistente"],
        cantidadDisponible: json["cantidadDisponible"],
        imagen: json["imagen"] ?? '',
        tipoid: json["tipoid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreRecurso": nombreRecurso,
        "cantidadExistente": cantidadExistente,
        "cantidadDisponible": cantidadDisponible,
        "imagen": imagen,
        "tipoid": tipoid,
      };
}
