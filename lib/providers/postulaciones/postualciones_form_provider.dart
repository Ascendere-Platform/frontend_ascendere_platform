import 'dart:convert';

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
      "equipo": equipo.map((player) => player.toJson()).toList(),
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
