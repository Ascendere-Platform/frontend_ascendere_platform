import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_postulaciones.dart';

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
      "equipo": [
        {
          "id": "619d4c914d53f321a7b2e1bd",
          "asignaturaID": "619568b34f1b2b2c8ee8c9d9",
          "cargo": "Desarrollador"
        },
        {
          "id": "619d4c247ee57a61c58f1d36",
          "asignaturaID": "619568b34f1b2b2c8ee8c9d9",
          "cargo": "Ing"
        }
      ],
      "convocatoriaID": convocatoriaId,
      "tipoProyectoId": tipoProyectoId
    };

    try {
      MicroPostulaciones.post('/registrarPostulacion', data).then((resp) {
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
