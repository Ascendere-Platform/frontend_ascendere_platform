import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_convocatorias.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_register.dart';

class ConvocatoriaProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ConvocatoriaRegister? convocatoriaRegister;
  List<ConvocatoriaResponse> convocatorias = [];
  List<TiposProyecto> typesProjets = [];
  List<AnexosConvocatoria> anexos = [];
  List<LineasEstrategica> strategicLines = [];
  List<ResultadosEsperado> expectedResults = [];
  List<RubricasConvocatoria> rubrics = [];

  bool isLoading = true;

  String name = '';
  String period = '';
  String background = '';
  String objetives = '';
  String compromises = '';
  String recipients = '';
  String recognitions = '';
  String contacts = '';
  List<String> newTypesProject = [];
  List<String> newAnnexes = [];
  List<String> newStrategicLines = [];
  List<String> newExpectedResults = [];
  List<String> newRubrics = [];
  List<String> newResource = [];

  ConvocatoriaProvider() {
    getTypes();
    getAnexos();
    getLines();
    getExpectedResults();
    getRubrics();
  }

  Future newConvocatoria() async {
    if (!validateForm()) return false;

    final data = {
      "nombreConvocatoria": name,
      "periodoConvocatoria": period,
      "antecedentes": background,
      "objetivos": objetives,
      "banner": "www.imagen.com",
      "destinatario": recipients,
      "reconocimiento": recognitions,
      "compromisos": compromises,
      "contactos": contacts,
      "calificacionPostulacion": 10,
      "calificacionProyecto": 10,
      "anexosConvocatoria": newAnnexes,
      "resultadosEsperados": newExpectedResults,
      "tiposProyectos": newTypesProject,
      "lineasEstrategicas": newStrategicLines,
      "rubricasConvocatoria": newRubrics,
      "recursosConvocatoria": newResource,
    };

    try {
      MicroConvocatorias.post('/registrarConvocatoria', data).then((resp) {
        NotificationsService.showSnackbar('Convocatoria creada');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError('Convocatoria no creada, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  getTypes() async {
    final resp = await MicroConvocatorias.get('/listarTiposProyectos');
    List<dynamic> list = json.decode(resp);

    for (var typeProject in list) {
      typesProjets.add(TiposProyecto.fromMap(typeProject));
    }

    isLoading = false;

    notifyListeners();
  }

  getAnexos() async {
    final resp = await MicroConvocatorias.get('/listarAnexos');
    List<dynamic> list = json.decode(resp);
    anexos.clear();

    for (var anexo in list) {
      anexos.add(AnexosConvocatoria.fromMap(anexo));
    }

    isLoading = false;

    notifyListeners();
  }

  registerAnnexe(String nameAnnexe, String linkAnnexe) async {
    final data = {"nombreAnexo": nameAnnexe, "link": linkAnnexe};

    try {
      final resp = await MicroConvocatorias.post('/registrarAnexo', data);
      getAnexos();

      notifyListeners();
    } catch (e) {
      throw 'Error al crear categoria';
    }
  }

  getLines() async {
    final resp = await MicroConvocatorias.get('/listarLineas');
    List<dynamic> list = json.decode(resp);

    for (var line in list) {
      strategicLines.add(LineasEstrategica.fromMap(line));
    }

    isLoading = false;

    notifyListeners();
  }

  getExpectedResults() async {
    final resp = await MicroConvocatorias.get('/listarResultadosEsperados');
    List<dynamic> list = json.decode(resp);

    for (var expectedResult in list) {
      expectedResults.add(ResultadosEsperado.fromMap(expectedResult));
    }

    isLoading = false;

    notifyListeners();
  }

  getRubrics() async {
    final resp = await MicroConvocatorias.get('/listarRubricas');
    List<dynamic> list = json.decode(resp);

    for (var rubric in list) {
      rubrics.add(RubricasConvocatoria.fromMap(rubric));
    }

    isLoading = false;

    notifyListeners();
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
