import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_register.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';
import 'package:frontend_ascendere_platform/models/http/resource_response.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';
import 'package:frontend_ascendere_platform/providers/resources_provider.dart';
import 'package:frontend_ascendere_platform/services/navigation_service.dart';
import 'package:frontend_ascendere_platform/ui/buttons/custom_icon_button_text.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard_action.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/modals/annexes_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/expected_result_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/rubric_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/strategic_lines_modal.dart';
import 'package:frontend_ascendere_platform/ui/modals/types_project_modal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

class ConvocatoriaView extends StatefulWidget {
  const ConvocatoriaView({Key? key, required this.cid}) : super(key: key);
  final String cid;

  @override
  _ConvocatoriaViewState createState() => _ConvocatoriaViewState();
}

class _ConvocatoriaViewState extends State<ConvocatoriaView> {
  ConvocatoriaRegister? conv;
  ConvocatoriaResponse? convResp;

  @override
  void initState() {
    super.initState();
    final convProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    final convFormProvider =
        Provider.of<ConvocatoriaFormProvider>(context, listen: false);

    convProvider.getConvocatoriasId(widget.cid).then((convDB) {
      if (convDB != null) {
        convFormProvider.convResp = convDB;
        convFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          convResp = convDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/convocatorias');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    convResp = null;
    conv = null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Convocatoria',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              if (convResp == null)
                CardDashboard(
                  child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              if (convResp != null) const _ConvocatoriaViewBody()
            ],
          ),
        ),
      ],
    );
  }
}

class _ConvocatoriaViewBody extends StatelessWidget {
  const _ConvocatoriaViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      // columnWidths: const {0: FixedColumnWidth(600)},
      children: const [
        TableRow(children: [
          // Avatar
          _ModifyConvocatoriaView(),
          // _AvatarContainer(),

          // _UserViewForm(),
        ])
      ],
    );
  }
}

class _ModifyConvocatoriaView extends StatefulWidget {
  const _ModifyConvocatoriaView({Key? key}) : super(key: key);

  @override
  State<_ModifyConvocatoriaView> createState() =>
      _ModifyConvocatoriaViewState();
}

class _ModifyConvocatoriaViewState extends State<_ModifyConvocatoriaView> {
  List<String> _selectedtypesProject = [];

  List<dynamic> _selectedAnnexes = [];

  List<dynamic> _selectedStrategicLines = [];

  List<dynamic> _selectedExpectedResults = [];

  List<dynamic> _selectedRubrics = [];

  List<dynamic> _selectedResource = [];

  bool hasAnnexes = true;
  bool hasStrategicLines = true;
  bool hasExpectedResults = true;
  bool hasRubrics = true;
  bool hasResource = true;

  bool isValidate = false;

  @override
  void initState() {
    super.initState();
    final convFormProvider =
        Provider.of<ConvocatoriaFormProvider>(context, listen: false);

    final conv = convFormProvider.convResp!;

    for (var item in conv.tiposProyectos) {
      _selectedtypesProject.add(item.id);
    }

    convFormProvider.setConvocatoria(
      id: conv.id,
      nombreConvocatoria: conv.nombreConvocatoria,
      periodoConvocatoria: conv.periodoConvocatoria,
      antecedentes: conv.antecedentes,
      objetivos: conv.objetivos,
      banner: conv.banner,
      destinatario: conv.destinatario,
      reconocimiento: conv.reconocimiento,
      compromisos: conv.compromisos,
      contactos: conv.contactos,
      calificacionPostulacion: conv.calificacionPostulacion,
      calificacionProyecto: conv.calificacionProyecto,
      anexosConvocatoria: <String>[],
      resultadosEsperados: <String>[],
      tiposProyectos: _selectedtypesProject,
      lineasEstrategicas: <String>[],
      rubricasConvocatoria: <String>[],
      recursosConvocatoria: <String>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    final convocatoriasProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);
    final resourcesProvider =
        Provider.of<ResourcesProvider>(context, listen: false);

    final convFormProvider =
        Provider.of<ConvocatoriaFormProvider>(context, listen: false);

    final conv = convFormProvider.convResp!;

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

    return Form(
      key: convFormProvider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Basics
          CardDashboard(
            title: 'Información basica',
            child: Column(
              children: [
                TextFormField(
                  initialValue: conv.nombreConvocatoria,
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
                  onChanged: (value) => convFormProvider.copyConvocatoriaWith(
                      nombreConvocatoria: value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: conv.periodoConvocatoria,
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
                  onChanged: (value) => convFormProvider.copyConvocatoriaWith(
                      periodoConvocatoria: value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: conv.antecedentes,
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
                  onChanged: (value) => convFormProvider.copyConvocatoriaWith(
                      antecedentes: value),
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
                  initialValue: conv.objetivos,
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
                      convFormProvider.copyConvocatoriaWith(objetivos: value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: conv.compromisos,
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
                  onChanged: (value) => convFormProvider.copyConvocatoriaWith(
                      compromisos: value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Types Projects
          CardDashboardAction(
            onPressed: () => const TypeProjectModal(),
            title: 'Tipos de proyecto',
            child: Column(children: [
              Wrap(
                spacing: 5,
                children: List.generate(
                  typesProjects.length,
                  (index) {
                    return FilterChip(
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
                    );
                  },
                ),
              ),
            ]),
          ),
          const SizedBox(height: 30),

          // Annexes
          CardDashboardAction(
            onPressed: () => const AnnexesModal(),
            title: 'Anexos',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    setState(() {
                      hasAnnexes = false;
                    });
                    _selectedAnnexes = results;
                  },
                  initialValue: const [],
                ),
                if (hasAnnexes) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 10),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: List.generate(
                        conv.anexosConvocatoria.length,
                        (index) {
                          return Chip(
                            label: Text(
                                conv.anexosConvocatoria[index].nombreAnexo),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),

          const SizedBox(height: 30),
          // Stratic Lines
          CardDashboardAction(
            onPressed: () => const StrategicLinesModal(),
            title: 'Líneas estratégicas',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    setState(() {
                      hasStrategicLines = false;
                    });
                    _selectedStrategicLines = results;
                  },
                  initialValue: const [],
                ),
                if (hasStrategicLines) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 10),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: List.generate(
                        conv.lineasEstrategicas.length,
                        (index) {
                          return Chip(
                            label: Text(
                                conv.lineasEstrategicas[index].nombreLinea),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),

          const SizedBox(height: 30),
          // Expected Results
          CardDashboardAction(
            onPressed: () => const ExpectedResultModal(),
            title: 'Resultados Esperados',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    setState(() {
                      hasExpectedResults = false;
                    });
                    _selectedExpectedResults = results;
                  },
                  initialValue: const [],
                ),
                if (hasExpectedResults) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 10),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: List.generate(
                        conv.resultadosEsperados.length,
                        (index) {
                          return Chip(
                            label: Text(conv
                                .resultadosEsperados[index].nombreResultado),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),

          const SizedBox(height: 30),
          // Rubrics
          CardDashboardAction(
            onPressed: () => const RubricModal(),
            title: 'Rubricas',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    setState(() {
                      hasRubrics = false;
                    });
                    _selectedRubrics = results;
                  },
                  initialValue: const [],
                ),
                if (hasRubrics) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 10),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: List.generate(
                        conv.rubricasConvocatoria.length,
                        (index) {
                          return Chip(
                            label: Text(conv
                                .rubricasConvocatoria[index].nombreRubrica),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Resources
          CardDashboard(
            title: 'Recursos',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    setState(() {
                      hasResource = false;
                    });
                    _selectedResource = results;
                  },
                  initialValue: _selectedResource,
                ),
                if (hasResource) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 10),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: List.generate(
                        conv.recursosConvocatoria.length,
                        (index) {
                          return Chip(
                            label: Text(conv
                                .recursosConvocatoria[index].nombreRecurso),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Additional
          CardDashboard(
            title: 'Información adicional',
            child: Column(
              children: [
                TextFormField(
                  initialValue: conv.destinatario,
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
                  onChanged: (value) => convFormProvider.copyConvocatoriaWith(
                      destinatario: value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: conv.reconocimiento,
                  decoration: CustomInputs.formInputDashboardDecoration(
                    hint: 'Ingrese los reconocimientos de la convocatoria',
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
                  onChanged: (value) => convFormProvider.copyConvocatoriaWith(
                      reconocimiento: value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: conv.contactos,
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
                      convFormProvider.copyConvocatoriaWith(contactos: value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              CustomIconButtonText(
                onPressed: () async {
                  convocatoriasProvider.newTypesProject =
                      _selectedtypesProject;

                  if (hasAnnexes) {
                    for (var item in conv.anexosConvocatoria) {
                      convocatoriasProvider.newAnnexes.add(item.id);
                    }
                  } else {
                    for (var item in _selectedAnnexes) {
                      convocatoriasProvider.newAnnexes.add(item.id);
                    }
                  }

                  if (hasStrategicLines) {
                    for (var item in conv.lineasEstrategicas) {
                      convocatoriasProvider.newStrategicLines.add(item.id);
                    }
                  } else {
                    for (var item in _selectedStrategicLines) {
                      convocatoriasProvider.newStrategicLines.add(item.id);
                    }
                  }

                  if (hasExpectedResults) {
                    for (var item in conv.resultadosEsperados) {
                      convocatoriasProvider.newExpectedResults.add(item.id);
                    }
                  } else {
                    for (var item in _selectedExpectedResults) {
                      convocatoriasProvider.newExpectedResults.add(item.id);
                    }
                  }

                  if (hasRubrics) {
                    for (var item in conv.rubricasConvocatoria) {
                      convocatoriasProvider.newRubrics.add(item.id);
                    }
                  } else {
                    for (var item in _selectedRubrics) {
                      convocatoriasProvider.newRubrics.add(item.id);
                    }
                  }

                  if (hasResource) {
                    for (var item in conv.recursosConvocatoria) {
                      convocatoriasProvider.newResource.add(item.id);
                    }
                  } else {
                    for (var item in _selectedResource) {
                      convocatoriasProvider.newResource.add(item.id);
                    }
                  }

                  convFormProvider.copyConvocatoriaWith(
                    anexosConvocatoria: convocatoriasProvider.newAnnexes,
                    resultadosEsperados:
                        convocatoriasProvider.newExpectedResults,
                    tiposProyectos: _selectedtypesProject,
                    lineasEstrategicas:
                        convocatoriasProvider.newStrategicLines,
                    rubricasConvocatoria: convocatoriasProvider.newRubrics,
                    recursosConvocatoria: convocatoriasProvider.newResource,
                  );

                  final save = await convFormProvider.updateConvocatoria();

                  if (!save) {
                    convocatoriasProvider.newAnnexes.clear();
                    convocatoriasProvider.newStrategicLines.clear();
                    convocatoriasProvider.newExpectedResults.clear();
                    convocatoriasProvider.newRubrics.clear();
                    convocatoriasProvider.newResource.clear();
                  }
                  setState(() {
                    isValidate = true;
                  });
                },
                icon: Icons.save,
                text: 'Confirmar',
              ),
              const SizedBox(width: 8),
              CustomIconButtonText(
                disable: isValidate ? false : true,
                onPressed: () {
                  convFormProvider.postConvocatoria();
                  NavigationService.naviageTo('/dashboard/convocatorias');
                },
                icon: Icons.send,
                text: 'Publicar',
              ),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
