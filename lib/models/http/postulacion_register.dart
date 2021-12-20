import 'dart:convert';

class PostualcionRegister {
  PostualcionRegister({
    required this.nombreProyecto,
    required this.justificacion,
    required this.alcance,
    required this.requerimientos,
    required this.equipo,
    required this.convocatoriaId,
    required this.tipoProyectoId,
  });

  String nombreProyecto;
  String justificacion;
  String alcance;
  String requerimientos;
  List<EquipoRegister> equipo;
  String convocatoriaId;
  String tipoProyectoId;

  factory PostualcionRegister.fromJson(String str) =>
      PostualcionRegister.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostualcionRegister.fromMap(Map<String, dynamic> json) =>
      PostualcionRegister(
        nombreProyecto: json["nombreProyecto"],
        justificacion: json["justificacion"],
        alcance: json["alcance"],
        requerimientos: json["requerimientos"],
        equipo: List<EquipoRegister>.from(
            json["equipo"].map((x) => EquipoRegister.fromMap(x))),
        convocatoriaId: json["convocatoriaID"],
        tipoProyectoId: json["tipoProyectoId"],
      );

  Map<String, dynamic> toMap() => {
        "nombreProyecto": nombreProyecto,
        "justificacion": justificacion,
        "alcance": alcance,
        "requerimientos": requerimientos,
        "equipo": List<dynamic>.from(equipo.map((x) => x.toMap())),
        "convocatoriaID": convocatoriaId,
        "tipoProyectoId": tipoProyectoId,
      };
}

class EquipoRegister {
  EquipoRegister({
    required this.id,
    this.asignaturaId,
    this.cargo,
  });

  String id;
  String? asignaturaId;
  String? cargo;

  factory EquipoRegister.fromJson(String str) =>
      EquipoRegister.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EquipoRegister.fromMap(Map<String, dynamic> json) => EquipoRegister(
        id: json["id"],
        asignaturaId: json["asignaturaID"] ?? '',
        cargo: json["cargo"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "asignaturaID": asignaturaId,
        "cargo": cargo,
      };
}
