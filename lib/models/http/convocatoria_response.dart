import 'dart:convert';

class ConvocatoriaResponse {
  ConvocatoriaResponse({
    required this.id,
    required this.nombreConvocatoria,
    required this.periodoConvocatoria,
    required this.antecedentes,
    required this.objetivos,
    required this.banner,
    required this.estado,
    required this.destinatario,
    required this.reconocimiento,
    required this.compromisos,
    required this.plazo,
    required this.contactos,
    required this.fechaCreacion,
    required this.calificacionPostulacion,
    required this.calificacionProyecto,
    required this.creadorConvocatoria,
    required this.anexosConvocatoria,
    required this.resultadosEsperados,
    required this.tiposProyectos,
    required this.lineasEstrategicas,
    required this.rubricasConvocatoria,
    required this.recursosConvocatoria,
  });

  String id;
  String nombreConvocatoria;
  String periodoConvocatoria;
  String antecedentes;
  String objetivos;
  String banner;
  bool estado;
  String destinatario;
  String reconocimiento;
  String compromisos;
  DateTime plazo;
  String contactos;
  DateTime fechaCreacion;
  double calificacionPostulacion;
  int calificacionProyecto;
  CreadorConvocatoria creadorConvocatoria;
  List<AnexosConvocatoria> anexosConvocatoria;
  List<ResultadosEsperado> resultadosEsperados;
  List<TiposProyecto> tiposProyectos;
  List<LineasEstrategica> lineasEstrategicas;
  List<RubricasConvocatoria> rubricasConvocatoria;
  List<RecursosConvocatoria> recursosConvocatoria;

  factory ConvocatoriaResponse.fromJson(String str) =>
      ConvocatoriaResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConvocatoriaResponse.fromMap(Map<String, dynamic> json) =>
      ConvocatoriaResponse(
        id: json["_id"],
        nombreConvocatoria: json["nombreConvocatoria"],
        periodoConvocatoria: json["periodoConvocatoria"],
        antecedentes: json["antecedentes"],
        objetivos: json["objetivos"],
        banner: json["banner"],
        estado: json["estado"] ?? false,
        destinatario: json["destinatario"],
        reconocimiento: json["reconocimiento"],
        compromisos: json["compromisos"],
        plazo: DateTime.parse(json["plazo"]),
        contactos: json["contactos"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        calificacionPostulacion: json["calificacionPostulacion"].toDouble(),
        calificacionProyecto: json["calificacionProyecto"],
        creadorConvocatoria:
            CreadorConvocatoria.fromMap(json["CreadorConvocatoria"]),
        anexosConvocatoria: List<AnexosConvocatoria>.from(
            json["anexosConvocatoria"]
                .map((x) => AnexosConvocatoria.fromMap(x))),
        resultadosEsperados: List<ResultadosEsperado>.from(
            json["resultadosEsperados"]
                .map((x) => ResultadosEsperado.fromMap(x))),
        tiposProyectos: List<TiposProyecto>.from(
            json["tiposProyectos"].map((x) => TiposProyecto.fromMap(x))),
        lineasEstrategicas: List<LineasEstrategica>.from(
            json["lineasEstrategicas"]
                .map((x) => LineasEstrategica.fromMap(x))),
        rubricasConvocatoria: List<RubricasConvocatoria>.from(
            json["rubricasConvocatoria"]
                .map((x) => RubricasConvocatoria.fromMap(x))),
        recursosConvocatoria: List<RecursosConvocatoria>.from(
            json["recursosConvocatoria"]
                .map((x) => RecursosConvocatoria.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "nombreConvocatoria": nombreConvocatoria,
        "periodoConvocatoria": periodoConvocatoria,
        "antecedentes": antecedentes,
        "objetivos": objetivos,
        "banner": banner,
        "estado": estado,
        "destinatario": destinatario,
        "reconocimiento": reconocimiento,
        "compromisos": compromisos,
        "plazo": plazo.toIso8601String(),
        "contactos": contactos,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "calificacionPostulacion": calificacionPostulacion,
        "calificacionProyecto": calificacionProyecto,
        "CreadorConvocatoria": creadorConvocatoria.toMap(),
        "anexosConvocatoria":
            List<dynamic>.from(anexosConvocatoria.map((x) => x.toMap())),
        "resultadosEsperados":
            List<dynamic>.from(resultadosEsperados.map((x) => x.toMap())),
        "tiposProyectos":
            List<dynamic>.from(tiposProyectos.map((x) => x.toMap())),
        "lineasEstrategicas":
            List<dynamic>.from(lineasEstrategicas.map((x) => x.toMap())),
        "rubricasConvocatoria":
            List<dynamic>.from(rubricasConvocatoria.map((x) => x.toMap())),
        "recursosConvocatoria":
            List<dynamic>.from(recursosConvocatoria.map((x) => x.toMap())),
      };
}

class AnexosConvocatoria {
  AnexosConvocatoria({
    required this.id,
    required this.nombreAnexo,
    required this.link,
    required this.fechaCreacion,
  });

  String id;
  String nombreAnexo;
  String link;
  DateTime fechaCreacion;

  factory AnexosConvocatoria.fromJson(String str) =>
      AnexosConvocatoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AnexosConvocatoria.fromMap(Map<String, dynamic> json) =>
      AnexosConvocatoria(
        id: json["id"],
        nombreAnexo: json["nombreAnexo"],
        link: json["link"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreAnexo": nombreAnexo,
        "link": link,
        "fechaCreacion": fechaCreacion.toIso8601String(),
      };
}

class CreadorConvocatoria {
  CreadorConvocatoria({
    required this.email,
    required this.id,
    required this.nombre,
  });

  String email;
  String id;
  String nombre;

  factory CreadorConvocatoria.fromJson(String str) =>
      CreadorConvocatoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreadorConvocatoria.fromMap(Map<String, dynamic> json) =>
      CreadorConvocatoria(
        email: json["email"],
        id: json["_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "_id": id,
        "nombre": nombre,
      };
}

class LineasEstrategica {
  LineasEstrategica({
    required this.id,
    required this.nombreLinea,
    required this.descripcionLinea,
  });

  String id;
  String nombreLinea;
  String descripcionLinea;

  factory LineasEstrategica.fromJson(String str) =>
      LineasEstrategica.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineasEstrategica.fromMap(Map<String, dynamic> json) =>
      LineasEstrategica(
        id: json["id"],
        nombreLinea: json["nombreLinea"],
        descripcionLinea: json["descripcionLinea"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreLinea": nombreLinea,
        "descripcionLinea": descripcionLinea,
      };
}

class RecursosConvocatoria {
  RecursosConvocatoria({
    required this.id,
    required this.nombreRecurso,
    required this.cantidadExistente,
    required this.cantidadDisponible,
    required this.imagen,
    required this.tipoRecurso,
  });

  String id;
  String nombreRecurso;
  int cantidadExistente;
  int cantidadDisponible;
  String imagen;
  TipoRecurso tipoRecurso;

  factory RecursosConvocatoria.fromJson(String str) =>
      RecursosConvocatoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecursosConvocatoria.fromMap(Map<String, dynamic> json) =>
      RecursosConvocatoria(
        id: json["id"],
        nombreRecurso: json["nombreRecurso"],
        cantidadExistente: json["cantidadExistente"],
        cantidadDisponible: json["cantidadDisponible"],
        imagen: json["imagen"],
        tipoRecurso: TipoRecurso.fromMap(json["TipoRecurso"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreRecurso": nombreRecurso,
        "cantidadExistente": cantidadExistente,
        "cantidadDisponible": cantidadDisponible,
        "imagen": imagen,
        "TipoRecurso": tipoRecurso.toMap(),
      };
}

class TipoRecurso {
  TipoRecurso({
    required this.id,
    required this.nombreTipo,
    required this.descripcionTipo,
  });

  String id;
  String nombreTipo;
  String descripcionTipo;

  factory TipoRecurso.fromJson(String str) =>
      TipoRecurso.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipoRecurso.fromMap(Map<String, dynamic> json) => TipoRecurso(
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

class ResultadosEsperado {
  ResultadosEsperado({
    required this.id,
    required this.nombreResultado,
    required this.descripcionResultado,
    required this.puntajeResultado,
  });

  String id;
  String nombreResultado;
  String descripcionResultado;
  num puntajeResultado;

  factory ResultadosEsperado.fromJson(String str) =>
      ResultadosEsperado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultadosEsperado.fromMap(Map<String, dynamic> json) =>
      ResultadosEsperado(
        id: json["id"],
        nombreResultado: json["nombreResultado"],
        descripcionResultado: json["descripcionResultado"],
        puntajeResultado: json["puntajeResultado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombreResultado": nombreResultado,
        "descripcionResultado": descripcionResultado,
        "puntajeResultado": puntajeResultado,
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

class TiposProyecto {
  TiposProyecto({
    required this.id,
    required this.tipoProyecto,
    required this.descripcionTipo,
    required this.presupuesto,
  });

  String id;
  String tipoProyecto;
  String descripcionTipo;
  num presupuesto;

  factory TiposProyecto.fromJson(String str) =>
      TiposProyecto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TiposProyecto.fromMap(Map<String, dynamic> json) => TiposProyecto(
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
