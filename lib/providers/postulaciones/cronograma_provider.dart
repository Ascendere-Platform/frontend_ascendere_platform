import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_postulaciones.dart';

import 'package:frontend_ascendere_platform/models/http/hito_responde.dart';
import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';

class CronogramaProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  List<Hito> hitos = [];

  getHitosId(String id) async {
    // final resp = await MicroPostulaciones.get('listarHitos?id=$id');
    // 61b1d9ad555438d1c76aa9sdsdsasd6

    try {
      final resp = await MicroPostulaciones.get('/listarHitos?id=$id');

      if (resp != null) {
        List<dynamic> list = json.decode(resp);
        hitos.clear();

        for (var postu in list) {
          hitos.add(Hito.fromMap(postu));
        }
        notifyListeners();
        return hitos;
      }
    } catch (e) {
      return null;
    }
  }

  getPostulacionId(String id) async {
    try {
      final resp = await MicroPostulaciones.get('/buscarPostulacion?id=$id');
      final conv = PostulacionResponse.fromJson(resp);
      return conv;
    } catch (e) {
      return null;
    }
  }
}
