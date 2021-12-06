import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_resources.dart';

import 'package:frontend_ascendere_platform/models/http/resource_response.dart';

class ResourcesProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  List<ResourceResponse> resources = [];

  bool isLoading = true;
  bool ascending = true;

  ResourcesProvider() {
    getResources();
  }

  getResources() async {
    final resp = await MicroResources.get('/listarRecursos');
    List<dynamic> list = json.decode(resp);

    for (var typeProject in list) {
      resources.add(ResourceResponse.fromMap(typeProject));
    }

    isLoading = false;

    notifyListeners();
  }
}
