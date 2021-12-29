import 'dart:convert';

class Hito {
  Hito({
    required this.id,
    required this.nombreHito,
    required this.entregables,
    required this.fechaInicio,
    required this.fechaFin,
    required this.postulacionId,
  });

  String id;
  String nombreHito;
  List<String> entregables;
  DateTime fechaInicio;
  DateTime fechaFin;
  String postulacionId;

  factory Hito.fromJson(String str) => Hito.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hito.fromMap(Map<String, dynamic> json) => Hito(
        id: json["id"],
        nombreHito: json["nombreHito"],
        entregables: List<String>.from(json["entregables"].map((x) => x)),
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: DateTime.parse(json["fechaFin"]),
        postulacionId: json["postulacionId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreHito": nombreHito,
        "entregables": List<dynamic>.from(entregables.map((x) => x)),
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaFin": fechaFin.toIso8601String(),
        "postulacionId": postulacionId,
      };
}
