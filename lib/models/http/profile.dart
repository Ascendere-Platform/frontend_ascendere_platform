import 'dart:convert';

class Profile {
  Profile({
    required this.id,
    required this.rol,
    required this.nombre,
    required this.fechaNacimiento,
    required this.email,
    required this.avatar,
  });

  String id;
  Rol rol;
  String nombre;
  DateTime fechaNacimiento;
  String email;
  String avatar;

  factory Profile.fromJson(String str) =>
      Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) =>
      Profile(
        id: json["id"],
        rol: Rol.fromMap(json["rol"]),
        nombre: json["nombre"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        email: json["email"],
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rol": rol.toMap(),
        "nombre": nombre,
        "fechaNacimiento": fechaNacimiento.toIso8601String(),
        "email": email,
        "avatar": avatar,
      };
}

class Rol {
  Rol({
    required this.id,
    required this.nombreRol,
  });

  String id;
  String nombreRol;

  factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id: json["id"],
        nombreRol: json["nombreRol"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreRol": nombreRol,
      };
}
