// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/providers/resources_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard_action.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';

import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';

import 'package:frontend_ascendere_platform/ui/modals/rubric_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/expected_result_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/strategic_lines_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/annexes_modal.dart';

import 'package:frontend_ascendere_platform/models/http/resource_response.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

class ConvocatoriasView extends StatefulWidget {
  const ConvocatoriasView({Key? key}) : super(key: key);

  @override
  State<ConvocatoriasView> createState() => _ConvocatoriasViewState();
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.name,
    required this.id,
  });
}

class _ConvocatoriasViewState extends State<ConvocatoriasView> {
  String dropdownValue = 'One';

  List<String> _selectedtypesProject = [];

  List<dynamic> _selectedAnnexes = [];

  List<dynamic> _selectedStrategicLines = [];

  List<dynamic> _selectedExpectedResults = [];

  List<dynamic> _selectedRubrics = [];

  List<dynamic> _selectedResource = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final convocatoriasProvider = Provider.of<ConvocatoriaProvider>(context);
    final resourcesProvider = Provider.of<ResourcesProvider>(context);

    final typesProjects = convocatoriasProvider.typesProjets;
    final annexes = convocatoriasProvider.anexos;
    final strategicLines = convocatoriasProvider.strategicLines;
    final expectedResults = convocatoriasProvider.expectedResults;
    final rubrics = convocatoriasProvider.rubrics;
    final resources = resourcesProvider.resources;

    final _itemsAnnexes = annexes
        .map((annexe) =>
            MultiSelectItem<AnexosConvocatoria>(annexe, annexe.nombreAnexo))
        .toList();

    final _itemsStrategicLines = strategicLines
        .map((strategicLine) => MultiSelectItem<LineasEstrategica>(
            strategicLine, strategicLine.nombreLinea))
        .toList();

    final _itemsExpectedResults = expectedResults
        .map((expectedResult) => MultiSelectItem<ResultadosEsperado>(
            expectedResult,
            expectedResult.nombreResultado +
                ": " +
                expectedResult.descripcionResultado))
        .toList();

    final _itemsRubrics = rubrics
        .map((rubric) => MultiSelectItem<RubricasConvocatoria>(
            rubric, rubric.nombreRubrica + ": " + rubric.descripcionRubrica))
        .toList();

    final _itemsResources = resources
        .map((resource) =>
            MultiSelectItem<ResourceResponse>(resource, resource.nombreRecurso))
        .toList();

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: convocatoriasProvider.formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crear Convocatoria',
                  style: GoogleFonts.quicksand(
                      fontSize: 24,
                      color: const Color(0xFF001B34),
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),
                // Annexes
                CardDashboardAction(
                  onPressed: () => const AnnexesModal(),
                  title: 'Anexos',
                  child: Column(
                    children: [
                      MultiSelectDialogField(
                        items: _itemsAnnexes,
                        title: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Selecciona"),
                        ),
                        searchable: true,
                        selectedColor: Colors.blue,
                        buttonIcon: const Icon(
                          Icons.add_box_outlined,
                          color: Color(0xFF00ACC1),
                        ),
                        buttonText: const Text(
                          "Agregar Anexos",
                          style: TextStyle(
                            color: Color(0xFF00ACC1),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedAnnexes = results;
                        },
                        initialValue: const [],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                // Stratic Lines
                CardDashboardAction(
                  onPressed: () => const StrategicLinesModal(),
                  title: 'Líneas estratégicas',
                  child: Column(
                    children: [
                      MultiSelectDialogField(
                        items: _itemsStrategicLines,
                        title: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Selecióna"),
                        ),
                        searchable: true,
                        selectedColor: Colors.blue,
                        buttonIcon: const Icon(
                          Icons.add_box_outlined,
                          color: Color(0xFF00ACC1),
                        ),
                        buttonText: const Text(
                          "Agregar líneas estratégicas",
                          style: TextStyle(
                            color: Color(0xFF00ACC1),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedStrategicLines = results;
                        },
                        initialValue: const [],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                // Expected esults
                CardDashboardAction(
                  onPressed: () => const ExpectedResultModal(),
                  title: 'Resultados Esperados',
                  child: Column(
                    children: [
                      MultiSelectDialogField(
                        items: _itemsExpectedResults,
                        title: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Selecciona"),
                        ),
                        searchable: true,
                        selectedColor: Colors.blue,
                        buttonIcon: const Icon(
                          Icons.add_box_outlined,
                          color: Color(0xFF00ACC1),
                        ),
                        buttonText: const Text(
                          "Agregar Resultados Esperados",
                          style: TextStyle(
                            color: Color(0xFF00ACC1),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedExpectedResults = results;
                        },
                        initialValue: const [],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                // Rubrics
                CardDashboardAction(
                  onPressed: () => const RubricModal(),
                  title: 'Rubricas',
                  child: Column(
                    children: [
                      MultiSelectDialogField(
                        items: _itemsRubrics,
                        title: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Selecciona"),
                        ),
                        searchable: true,
                        selectedColor: Colors.blue,
                        buttonIcon: const Icon(
                          Icons.add_box_outlined,
                          color: Color(0xFF00ACC1),
                        ),
                        buttonText: const Text(
                          "Agregar Rubrica",
                          style: TextStyle(
                            color: Color(0xFF00ACC1),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedRubrics = results;
                        },
                        initialValue: const [],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Resources
                CardDashboard(
                  title: 'Recursos',
                  child: Column(
                    children: [
                      MultiSelectDialogField(
                        items: _itemsResources,
                        title: const FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Selecciona"),
                        ),
                        searchable: true,
                        selectedColor: Colors.blue,
                        buttonIcon: const Icon(
                          Icons.add_box_outlined,
                          color: Color(0xFF00ACC1),
                        ),
                        buttonText: const Text(
                          "Agregar Recursos",
                          style: TextStyle(
                            color: Color(0xFF00ACC1),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedResource = results;
                        },
                        initialValue: _selectedResource,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Types Projects
                CardDashboard(
                  title: 'Tipos de proyecto',
                  child: Column(children: [
                    Wrap(
                      spacing: 5,
                      children: List.generate(
                        typesProjects.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: FilterChip(
                              selected: _selectedtypesProject
                                  .contains(typesProjects[index].id),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedtypesProject
                                        .add(typesProjects[index].id);
                                  } else {
                                    _selectedtypesProject.removeWhere((id) {
                                      return id == typesProjects[index].id;
                                    });
                                  }
                                });
                              },
                              label: Text(typesProjects[index].tipoProyecto),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 12),
                // Basics
                CardDashboard(
                  title: 'Información basica',
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint:
                              'Ejemplo: XVIII CONVOCATORIA DE BUENAS PRÁCTICAS Y PROYECTOS DE INNOVACIÓN DOCENTE PARA EL FOMENTO DEL PROCESO DE ENSEÑANZA-APRENDIZAJE',
                          label: 'Nombre',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un nombre';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.name = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ejemplo: abril-agosto 2024',
                          label: 'Periodo de la convocatoria',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese un periodo';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.period = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        maxLines: 12,
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ingrese los antecedentes de la convocatoria',
                          label: 'Antecedentes',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los antecedentes';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.background = value,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Objetives
                CardDashboard(
                  title: 'Objetivos',
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 12,
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ingrese los objetivos de la convocatoria',
                          label: 'Objetivos',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los objetivos';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.objetives = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ingrese los compromisos de la convocatoria',
                          label: 'Compromisos',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los compromisos';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.compromises = value,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Additional
                CardDashboard(
                  title: 'Información adicional',
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ingrese los destinatarios de la convocatoria',
                          label: 'Destinatarios',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los destinatarios';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.recipients = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint:
                              'Ingrese los reconocimientos de la convocatoria',
                          label: 'Reconocimiento',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los reconocientos';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.recognitions = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint:
                              'Ingrese la información de contacto de la convocatoria',
                          label: 'Contactos',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los contactos';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            convocatoriasProvider.contacts = value,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 120),
                  child: ElevatedButton(
                      onPressed: () async {
                        convocatoriasProvider.newTypesProject =
                            _selectedtypesProject;

                        for (var item in _selectedAnnexes) {
                          convocatoriasProvider.newAnnexes.add(item.id);
                        }

                        for (var item in _selectedStrategicLines) {
                          convocatoriasProvider.newStrategicLines.add(item.id);
                        }

                        for (var item in _selectedExpectedResults) {
                          convocatoriasProvider.newExpectedResults.add(item.id);
                        }

                        for (var item in _selectedRubrics) {
                          convocatoriasProvider.newRubrics.add(item.id);
                        }

                        for (var item in _selectedResource) {
                          convocatoriasProvider.newResource.add(item.id);
                        }

                        final save =
                            await convocatoriasProvider.newConvocatoria();
                        if (save) {
                          NotificationsService.showSnackbar(
                              'Convocatoria creada');
                          // TODO: actualizar convocatoria
                        } else {
                          NotificationsService.showSnackbarError(
                              'No se pudo crear la convocatoria');
                          convocatoriasProvider.newAnnexes.clear();
                          convocatoriasProvider.newStrategicLines.clear();
                          convocatoriasProvider.newExpectedResults.clear();
                          convocatoriasProvider.newRubrics.clear();
                          convocatoriasProvider.newResource.clear();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        shadowColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.save_outlined),
                          Text(' Guardar'),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
