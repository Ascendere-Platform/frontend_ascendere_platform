import 'dart:convert';

class TypesResourcesResponse {
  TypesResourcesResponse({
    required this.id,
    required this.nombreTipo,
    required this.descripcionTipo,
  });

  String id;
  String nombreTipo;
  String descripcionTipo;

  factory TypesResourcesResponse.fromJson(String str) =>
      TypesResourcesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypesResourcesResponse.fromMap(Map<String, dynamic> json) =>
      TypesResourcesResponse(
        id: json["id"],
        nombreTipo: json["nombreTipo"],
        descripcionTipo: json["descripcionTipo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreTipo": nombreTipo,
        "descripcionTipo": descripcionTipo,
      };
}
