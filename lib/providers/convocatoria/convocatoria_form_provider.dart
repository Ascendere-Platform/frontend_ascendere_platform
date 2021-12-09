import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_convocatorias.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_register.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

class ConvocatoriaFormProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;

  ConvocatoriaRegister? conv;
  ConvocatoriaResponse? convResp;

  setConvocatoria({
    String? id,
    String? nombreConvocatoria,
    String? periodoConvocatoria,
    String? antecedentes,
    String? objetivos,
    String? banner,
    String? destinatario,
    String? reconocimiento,
    String? compromisos,
    String? contactos,
    num? calificacionPostulacion,
    num? calificacionProyecto,
    List<String>? anexosConvocatoria,
    List<String>? resultadosEsperados,
    List<String>? tiposProyectos,
    List<String>? lineasEstrategicas,
    List<String>? rubricasConvocatoria,
    List<String>? recursosConvocatoria,
  }) {
    conv = ConvocatoriaRegister(
      id: id ?? conv!.id,
      nombreConvocatoria: nombreConvocatoria ?? conv!.nombreConvocatoria,
      periodoConvocatoria: periodoConvocatoria ?? conv!.periodoConvocatoria,
      antecedentes: antecedentes ?? conv!.antecedentes,
      objetivos: objetivos ?? conv!.objetivos,
      banner: banner ?? conv!.banner,
      destinatario: destinatario ?? conv!.destinatario,
      reconocimiento: reconocimiento ?? conv!.reconocimiento,
      compromisos: compromisos ?? conv!.compromisos,
      contactos: contactos ?? conv!.contactos,
      calificacionPostulacion:
          calificacionPostulacion ?? conv!.calificacionPostulacion,
      calificacionProyecto: calificacionProyecto ?? conv!.calificacionProyecto,
      anexosConvocatoria: anexosConvocatoria ?? conv!.anexosConvocatoria,
      resultadosEsperados: resultadosEsperados ?? conv!.resultadosEsperados,
      tiposProyectos: tiposProyectos ?? conv!.tiposProyectos,
      lineasEstrategicas: lineasEstrategicas ?? conv!.lineasEstrategicas,
      rubricasConvocatoria: rubricasConvocatoria ?? conv!.rubricasConvocatoria,
      recursosConvocatoria: recursosConvocatoria ?? conv!.recursosConvocatoria,
    );
  }

  copyConvocatoriaWith({
    String? id,
    String? nombreConvocatoria,
    String? periodoConvocatoria,
    String? antecedentes,
    String? objetivos,
    String? banner,
    String? destinatario,
    String? reconocimiento,
    String? compromisos,
    String? contactos,
    num? calificacionPostulacion,
    num? calificacionProyecto,
    List<String>? anexosConvocatoria,
    List<String>? resultadosEsperados,
    List<String>? tiposProyectos,
    List<String>? lineasEstrategicas,
    List<String>? rubricasConvocatoria,
    List<String>? recursosConvocatoria,
  }) {
    conv = ConvocatoriaRegister(
      id: id ?? conv!.id,
      nombreConvocatoria: nombreConvocatoria ?? conv!.nombreConvocatoria,
      periodoConvocatoria: periodoConvocatoria ?? conv!.periodoConvocatoria,
      antecedentes: antecedentes ?? conv!.antecedentes,
      objetivos: objetivos ?? conv!.objetivos,
      banner: banner ?? conv!.banner,
      destinatario: destinatario ?? conv!.destinatario,
      reconocimiento: reconocimiento ?? conv!.reconocimiento,
      compromisos: compromisos ?? conv!.compromisos,
      contactos: contactos ?? conv!.contactos,
      calificacionPostulacion:
          calificacionPostulacion ?? conv!.calificacionPostulacion,
      calificacionProyecto: calificacionProyecto ?? conv!.calificacionProyecto,
      anexosConvocatoria: anexosConvocatoria ?? conv!.anexosConvocatoria,
      resultadosEsperados: resultadosEsperados ?? conv!.resultadosEsperados,
      tiposProyectos: tiposProyectos ?? conv!.tiposProyectos,
      lineasEstrategicas: lineasEstrategicas ?? conv!.lineasEstrategicas,
      rubricasConvocatoria: rubricasConvocatoria ?? conv!.rubricasConvocatoria,
      recursosConvocatoria: recursosConvocatoria ?? conv!.recursosConvocatoria,
    );
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future updateConvocatoria() async {
    if (!validateForm()) {
      print('es el formulario');
      return false;
    }

    final data = {
      "_id": conv!.id,
      "nombreConvocatoria": conv!.nombreConvocatoria,
      "periodoConvocatoria": conv!.periodoConvocatoria,
      "antecedentes": conv!.antecedentes,
      "objetivos": conv!.objetivos,
      "banner": "www.imagen.com",
      "destinatario": conv!.destinatario,
      "reconocimiento": conv!.reconocimiento,
      "compromisos": conv!.compromisos,
      "contactos": conv!.contactos,
      "calificacionPostulacion": 10,
      "calificacionProyecto": 10,
      "anexosConvocatoria": conv!.anexosConvocatoria,
      "resultadosEsperados": conv!.resultadosEsperados,
      "tiposProyectos": conv!.tiposProyectos,
      "lineasEstrategicas": conv!.lineasEstrategicas,
      "rubricasConvocatoria": conv!.rubricasConvocatoria,
      "recursosConvocatoria": conv!.recursosConvocatoria,
    };

    print(data);

    try {
      MicroConvocatorias.put('/actualizarConvocatoria', data).then((resp) {
        NotificationsService.showSnackbar('Convocatoria actualizada');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError(
            'Convocatoria no actualizada, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future postConvocatoria() async {
    final data = {
      "_id": conv!.id,
      "estado": true,
    };

    try {
      MicroConvocatorias.put('/actualizarConvocatoria', data).then((resp) {
        NotificationsService.showSnackbar('Convocatoria publicada');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError('Convocatoria no publicada, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
