import 'dart:convert';

class User {
  User({
    required this.id,
    required this.biografia,
    required this.email,
    required this.exp,
    required this.fechaNacimiento,
    required this.nombre,
    required this.rol,
    required this.sitioweb,
    required this.ubicacion,
  });

  String id;
  String biografia;
  String email;
  int exp;
  DateTime fechaNacimiento;
  String nombre;
  String rol;
  String sitioweb;
  String ubicacion;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        biografia: json["biografia"],
        email: json["email"],
        exp: json["exp"],
        fechaNacimiento: DateTime.parse(json["fecha_Nacimiento"]),
        nombre: json["nombre"],
        rol: json["rol"],
        sitioweb: json["sitioweb"],
        ubicacion: json["ubicacion"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "biografia": biografia,
        "email": email,
        "exp": exp,
        "fecha_Nacimiento": fechaNacimiento.toIso8601String(),
        "nombre": nombre,
        "rol": rol,
        "sitioweb": sitioweb,
        "ubicacion": ubicacion,
      };
}
