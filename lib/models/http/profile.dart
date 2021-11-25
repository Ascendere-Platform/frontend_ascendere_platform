import 'dart:convert';

class Profile {
  Profile({
    required this.rolid,
    required this.nombre,
    required this.apellidos,
    required this.id,
    required this.fechaNacimiento,
    required this.email,
    required this.avatar,
  });

  String id;
  String rolid;
  String nombre;
  String apellidos;
  DateTime fechaNacimiento;
  String email;
  String avatar;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        id: json["id"],
        rolid: json["rolid"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rolid": rolid,
        "nombre": nombre,
        "apellidos": apellidos,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "email": email,
        "avatar": avatar,
      };
}
