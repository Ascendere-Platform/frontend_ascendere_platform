import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_convocatorias.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/postulacion_register.dart';

class PostulacionesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PostualcionRegister? postuRegister;

  String nombreProyecto = '';
  String justificacion = '';
  String alcance = '';
  String requerimientos = '';
  String convocatoriaId = '';
  String tipoProyectoId = '';
  List<EquipoRegister> equipo = [];

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future resgisterPostulacion() async {
    if (!validateForm()) {
      return false;
    }

    final data = {
      "nombreProyecto": nombreProyecto,
      "justificacion": justificacion,
      "alcance": alcance,
      "requerimientos": requerimientos,
      "equipo": equipo,
      "convocatoriaID": convocatoriaId,
      "tipoProyectoId": tipoProyectoId
    };

    print(data);

    try {
      MicroConvocatorias.put('/registrarPostulacion', data).then((resp) {
        NotificationsService.showSnackbar('Postualción registrada');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError('Postulación no registrada, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
