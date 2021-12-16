import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_postulaciones.dart';

import 'package:frontend_ascendere_platform/api/micro_resources.dart';
import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';

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
    final resp = await MicroPostulaciones.get('listarPostulaciones');
    List<dynamic> list = json.decode(resp);
    postulaciones.clear();

    for (var postu in list) {
      postulaciones.add(PostulacionResponse.fromMap(postu));
    }

    isLoading = false;

    notifyListeners();
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

  registerResource(String name, String img, int quantity, String typeId) async {
    final data = {
      "nombreRecurso": name,
      "cantidadExistente": quantity,
      "imagen": img,
      "tipoid": typeId,
    };

    try {
      await MicroResources.post('registroRecurso', data);
      getPostulaciones();
      notifyListeners();
    } catch (e) {
      throw 'Error al crear el recurso';
    }
  }

  updateResource(
      String id, String name, String img, int quantity, String typeId) async {
    final data = {
      "id": id,
      "nombreRecurso": name,
      "cantidadExistente": quantity,
      "imagen": img,
      "tipoid": typeId,
    };

    try {
      await MicroResources.put('actualizarRecurso', data);
      getPostulaciones();
      notifyListeners();
    } catch (e) {
      throw 'Error al crear el recurso';
    }
  }

  Future deleteResource(String id) async {
    try {
      await MicroResources.delete('/eliminarRecurso?id=$id');

      postulaciones.removeWhere((categoria) => categoria.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar categoria';
    }
  }
}
