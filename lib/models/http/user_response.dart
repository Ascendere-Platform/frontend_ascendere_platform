import 'dart:convert';

class UserResponse {
  UserResponse({
    required this.id,
    required this.rolid,
    required this.nombre,
    required this.apellidos,
    required this.fechaNacimiento,
    required this.email,
  });

  String id;
  String rolid;
  String nombre;
  String apellidos;
  DateTime fechaNacimiento;
  String email;

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        rolid: json["rolid"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rolid": rolid,
        "nombre": nombre,
        "apellidos": apellidos,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "email": email,
      };
}
