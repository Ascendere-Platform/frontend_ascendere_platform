import 'dart:math';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_postulaciones.dart';

import 'package:frontend_ascendere_platform/models/http/hito_responde.dart';
import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';
import 'package:frontend_ascendere_platform/models/meeting.dart';

class CronogramaProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Hito> hitos = [];
  List<Meeting> meetings = [];

  String name = '';
  List<String> results = [];
  DateTime? fechaInicio;
  DateTime? fechaFin;

  final Random random = Random();

  final List<Color> _colorCollection = const [
    Color(0xFF0F8644),
    Color(0xFF8B1FA9),
    Color(0xFFD20100),
    Color(0xFFFC571D),
    Color(0xFF36B37B),
    Color(0xFF01A1EF),
    Color(0xFF3D4FB5),
    Color(0xFFE47C73),
    Color(0xFF636363),
  ];

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

  registerHito(String idPostu) async {
    for (var item in hitos) {
      final data = {
        "nombreHito": item.nombreHito,
        "entregables": item.entregables,
        "fechaInicio":
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(item.fechaInicio),
        "fechaFin":
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(item.fechaFin),
        "postulacionId": idPostu,
      };

      print(data);
      try {
        await MicroPostulaciones.post('/registrarHito', data);

        notifyListeners();
      } catch (e) {
        throw 'Error al crear hito del proyecto';
      }
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  addHito() {
    hitos.add(
      Hito(
        id: '',
        nombreHito: name,
        entregables: results,
        fechaInicio: fechaInicio!,
        fechaFin: fechaFin!,
        postulacionId: '',
      ),
    );

    meetings.add(Meeting(
        eventName: name,
        from: fechaInicio!,
        to: fechaFin!,
        background: _colorCollection[random.nextInt(8)],
        isAllDay: false));

    notifyListeners();
  }
}
