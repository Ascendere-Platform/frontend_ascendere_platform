import 'dart:convert';

class PostulacionResponse {
  PostulacionResponse({
    required this.id,
    required this.nombreProyecto,
    required this.justificacion,
    required this.alcance,
    required this.requerimientos,
    required this.fechaInicio,
    required this.fechaActualizacion,
    required this.fechaPublicacion,
    required this.equipo,
    required this.convocatoria,
    required this.mensaje,
    required this.tipoProyecto,
    this.estado,
  });

  String id;
  String nombreProyecto;
  String justificacion;
  String? alcance;
  String requerimientos;
  DateTime fechaInicio;
  DateTime fechaActualizacion;
  List<Equipo> equipo;
  Convocatoria convocatoria;
  String mensaje;
  TipoProyecto tipoProyecto;
  DateTime? fechaPublicacion;
  bool? estado;

  factory PostulacionResponse.fromJson(String str) =>
      PostulacionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostulacionResponse.fromMap(Map<String, dynamic> json) =>
      PostulacionResponse(
        id: json["id"],
        nombreProyecto: json["nombreProyecto"],
        justificacion: json["justificacion"],
        alcance: json["alcance"] ?? '',
        requerimientos: json["requerimientos"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
        fechaPublicacion: DateTime.parse(json["fechaPublicacion"]),
        equipo: List<Equipo>.from(json["equipo"].map((x) => Equipo.fromMap(x))),
        convocatoria: Convocatoria.fromMap(json["convocatoria"]),
        mensaje: json["mensaje"],
        tipoProyecto: TipoProyecto.fromMap(json["tipoProyecto"]),
        estado: json["estado"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreProyecto": nombreProyecto,
        "justificacion": justificacion,
        "alcance": alcance,
        "requerimientos": requerimientos,
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
        "equipo": List<dynamic>.from(equipo.map((x) => x.toMap())),
        "convocatoria": convocatoria.toMap(),
        "mensaje": mensaje,
        "tipoProyecto": tipoProyecto.toMap(),
        "estado": estado,
      };
}

class Convocatoria {
  Convocatoria({
    required this.id,
    required this.nombreConvocatoria,
    required this.periodoConvocatoria,
    required this.calificacionPostulacion,
    required this.rubricasConvocatoria,
  });

  String id;
  String nombreConvocatoria;
  String periodoConvocatoria;
  int calificacionPostulacion;
  List<RubricasConvocatoria> rubricasConvocatoria;

  factory Convocatoria.fromJson(String str) =>
      Convocatoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Convocatoria.fromMap(Map<String, dynamic> json) => Convocatoria(
        id: json["_id"],
        nombreConvocatoria: json["nombreConvocatoria"],
        periodoConvocatoria: json["periodoConvocatoria"],
        calificacionPostulacion: json["calificacionPostulacion"],
        rubricasConvocatoria: List<RubricasConvocatoria>.from(
            json["rubricasConvocatoria"]
                .map((x) => RubricasConvocatoria.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombreConvocatoria": nombreConvocatoria,
        "periodoConvocatoria": periodoConvocatoria,
        "calificacionPostulacion": calificacionPostulacion,
        "rubricasConvocatoria":
            List<dynamic>.from(rubricasConvocatoria.map((x) => x.toMap())),
      };
}

class RubricasConvocatoria {
  RubricasConvocatoria({
    required this.id,
    required this.nombreRubrica,
    required this.descripcionRubrica,
    required this.puntajeRubrica,
  });

  String id;
  String nombreRubrica;
  String descripcionRubrica;
  double puntajeRubrica;

  factory RubricasConvocatoria.fromJson(String str) =>
      RubricasConvocatoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RubricasConvocatoria.fromMap(Map<String, dynamic> json) =>
      RubricasConvocatoria(
        id: json["id"],
        nombreRubrica: json["nombreRubrica"],
        descripcionRubrica: json["descripcionRubrica"],
        puntajeRubrica: json["puntajeRubrica"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreRubrica": nombreRubrica,
        "descripcionRubrica": descripcionRubrica,
        "puntajeRubrica": puntajeRubrica,
      };
}

class Equipo {
  Equipo({
    required this.id,
    required this.nombre,
    required this.email,
    this.cargo,
    this.asignatura,
  });

  String id;
  String nombre;
  String email;
  String? cargo;
  Asignatura? asignatura;

  factory Equipo.fromJson(String str) => Equipo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Equipo.fromMap(Map<String, dynamic> json) => Equipo(
        id: json["id"],
        nombre: json["nombre"],
        email: json["email"],
        asignatura: Asignatura.fromMap(json["asignatura"] ?? ''),
        cargo: json["cargo"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "email": email,
        "asignatura": asignatura!.toMap(),
        "cargo": cargo,
      };
}

class Asignatura {
  Asignatura({
    this.id,
    this.nombreAsignatura,
    this.modalidad,
    this.facultadid,
    this.periodo,
  });

  String? id;
  String? nombreAsignatura;
  String? modalidad;
  String? facultadid;
  String? periodo;

  factory Asignatura.fromJson(String str) =>
      Asignatura.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Asignatura.fromMap(Map<String, dynamic> json) => Asignatura(
        id: json["id"] ?? '',
        nombreAsignatura: json["nombreAsignatura"] ?? '',
        modalidad: json["modalidad"] ?? '',
        facultadid: json["facultadid"] ?? '',
        periodo: json["periodo"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreAsignatura": nombreAsignatura,
        "modalidad": modalidad,
        "facultadid": facultadid,
        "periodo": periodo,
      };
}

class TipoProyecto {
  TipoProyecto({
    required this.id,
    required this.tipoProyecto,
    required this.descripcionTipo,
    required this.presupuesto,
  });

  String id;
  String tipoProyecto;
  String descripcionTipo;
  num presupuesto;

  factory TipoProyecto.fromJson(String str) =>
      TipoProyecto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipoProyecto.fromMap(Map<String, dynamic> json) => TipoProyecto(
        id: json["id"],
        tipoProyecto: json["tipoProyecto"],
        descripcionTipo: json["descripcionTipo"],
        presupuesto: json["presupuesto"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tipoProyecto": tipoProyecto,
        "descripcionTipo": descripcionTipo,
        "presupuesto": presupuesto,
      };
}
