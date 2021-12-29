import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_postulaciones.dart';

import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

class PostulacionesProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  List<PostulacionResponse> postulaciones = [];
  int? sortColumnIndex;

  bool isLoading = true;
  bool ascending = true;

  PostulacionesProvider() {
    getPostulaciones();
  }

  getPostulaciones() async {
    final resp = await MicroPostulaciones.get('/listarPostulaciones');
    List<dynamic> list = json.decode(resp);
    postulaciones.clear();

    for (var postu in list) {
      postulaciones.add(PostulacionResponse.fromMap(postu));
    }

    isLoading = false;

    notifyListeners();
  }

  getPostulacionesId() async {
    final resp = await MicroPostulaciones.get('/listarPostulaciones');
    List<dynamic> list = json.decode(resp);
    List<PostulacionResponse> postulacionesTemp = [];

    for (var postu in list) {
      postulacionesTemp.add(PostulacionResponse.fromMap(postu));
    }

    return postulacionesTemp.last.id;
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

  approvedPostulacion(String id) async {
    final data = {
      "id": id,
      "estado": true,
    };

    try {
      MicroPostulaciones.putData('/publicarPostulacion', data).then((resp) {
        NotificationsService.showSnackbar('Proyecto aprobado');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError('Proyecto no aprobado, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void sort<T>(Comparable<T> Function(PostulacionResponse user) getField) {
    postulaciones.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }
}
