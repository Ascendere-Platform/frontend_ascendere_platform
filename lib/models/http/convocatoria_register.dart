import 'dart:convert';

class ConvocatoriaRegister {
  ConvocatoriaRegister({
    required this.nombreConvocatoria,
    required this.periodoConvocatoria,
    required this.antecedentes,
    required this.objetivos,
    required this.banner,
    required this.destinatario,
    required this.reconocimiento,
    required this.compromisos,
    required this.contactos,
    required this.calificacionPostulacion,
    required this.calificacionProyecto,
    required this.anexosConvocatoria,
    required this.resultadosEsperados,
    required this.tiposProyectos,
    required this.lineasEstrategicas,
    required this.rubricasConvocatoria,
    required this.recursosConvocatoria,
  });

  String nombreConvocatoria;
  String periodoConvocatoria;
  String antecedentes;
  String objetivos;
  String banner;
  String destinatario;
  String reconocimiento;
  String compromisos;
  String contactos;
  int calificacionPostulacion;
  int calificacionProyecto;
  List<String> anexosConvocatoria;
  List<String> resultadosEsperados;
  List<String> tiposProyectos;
  List<String> lineasEstrategicas;
  List<String> rubricasConvocatoria;
  List<String> recursosConvocatoria;

  factory ConvocatoriaRegister.fromJson(String str) =>
      ConvocatoriaRegister.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConvocatoriaRegister.fromMap(Map<String, dynamic> json) =>
      ConvocatoriaRegister(
        nombreConvocatoria: json["nombreConvocatoria"],
        periodoConvocatoria: json["periodoConvocatoria"],
        antecedentes: json["antecedentes"],
        objetivos: json["objetivos"],
        banner: json["banner"],
        destinatario: json["destinatario"],
        reconocimiento: json["reconocimiento"],
        compromisos: json["compromisos"],
        contactos: json["contactos"],
        calificacionPostulacion: json["calificacionPostulacion"],
        calificacionProyecto: json["calificacionProyecto"],
        anexosConvocatoria:
            List<String>.from(json["anexosConvocatoria"].map((x) => x)),
        resultadosEsperados:
            List<String>.from(json["resultadosEsperados"].map((x) => x)),
        tiposProyectos: List<String>.from(json["tiposProyectos"].map((x) => x)),
        lineasEstrategicas:
            List<String>.from(json["lineasEstrategicas"].map((x) => x)),
        rubricasConvocatoria:
            List<String>.from(json["rubricasConvocatoria"].map((x) => x)),
        recursosConvocatoria:
            List<String>.from(json["recursosConvocatoria"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "nombreConvocatoria": nombreConvocatoria,
        "periodoConvocatoria": periodoConvocatoria,
        "antecedentes": antecedentes,
        "objetivos": objetivos,
        "banner": banner,
        "destinatario": destinatario,
        "reconocimiento": reconocimiento,
        "compromisos": compromisos,
        "contactos": contactos,
        "calificacionPostulacion": calificacionPostulacion,
        "calificacionProyecto": calificacionProyecto,
        "anexosConvocatoria":
            List<dynamic>.from(anexosConvocatoria.map((x) => x)),
        "resultadosEsperados":
            List<dynamic>.from(resultadosEsperados.map((x) => x)),
        "tiposProyectos": List<dynamic>.from(tiposProyectos.map((x) => x)),
        "lineasEstrategicas":
            List<dynamic>.from(lineasEstrategicas.map((x) => x)),
        "rubricasConvocatoria":
            List<dynamic>.from(rubricasConvocatoria.map((x) => x)),
        "recursosConvocatoria":
            List<dynamic>.from(recursosConvocatoria.map((x) => x)),
      };
}
