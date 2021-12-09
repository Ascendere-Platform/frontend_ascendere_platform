class ConvocatoriaRegister {
  ConvocatoriaRegister({
    required this.id,
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

  String id;
  String nombreConvocatoria;
  String periodoConvocatoria;
  String antecedentes;
  String objetivos;
  String banner;
  String destinatario;
  String reconocimiento;
  String compromisos;
  String contactos;
  num calificacionPostulacion;
  num calificacionProyecto;
  List<String> anexosConvocatoria;
  List<String> resultadosEsperados;
  List<String> tiposProyectos;
  List<String> lineasEstrategicas;
  List<String> rubricasConvocatoria;
  List<String> recursosConvocatoria;
}
