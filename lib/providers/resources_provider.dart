import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_resources.dart';

import 'package:frontend_ascendere_platform/models/http/resource_response.dart';
import 'package:frontend_ascendere_platform/models/http/types_resources.dart';

class ResourcesProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  List<ResourceResponse> resources = [];
  List<TypesResourcesResponse> types = [];
  int? sortColumnIndex;

  bool isLoading = true;
  bool ascending = true;

  ResourcesProvider() {
    getResources();
    getTypes();
  }

  getResources() async {
    final resp = await MicroResources.get('/listarRecursos');
    List<dynamic> list = json.decode(resp);
    resources.clear();

    for (var typeProject in list) {
      resources.add(ResourceResponse.fromMap(typeProject));
    }

    isLoading = false;

    notifyListeners();
  }

  getTypes() async {
    final resp = await MicroResources.get('/listarTipo');
    List<dynamic> list = json.decode(resp);

    for (var typeProject in list) {
      types.add(TypesResourcesResponse.fromMap(typeProject));
    }

    isLoading = false;

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(ResourceResponse user) getField) {
    resources.sort((a, b) {
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
      getResources();
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
      getResources();
      notifyListeners();
    } catch (e) {
      throw 'Error al crear el recurso';
    }
  }

  Future deleteResource(String id) async {
    try {
      await MicroResources.delete('/eliminarRecurso?id=$id');

      resources.removeWhere((categoria) => categoria.id == id);

      notifyListeners();
    } catch (e) {
      throw 'Error al eliminar categoria';
    }
  }
}
