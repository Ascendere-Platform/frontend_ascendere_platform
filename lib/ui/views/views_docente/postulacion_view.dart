import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';
import 'package:frontend_ascendere_platform/models/http/postulacion_register.dart';
import 'package:frontend_ascendere_platform/models/http/profile.dart';
import 'package:frontend_ascendere_platform/providers/postulaciones/postualciones_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/users_provider.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard_action.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/ui/cards/cards_convocatorias.dart';

class PostulacionView extends StatefulWidget {
  const PostulacionView({Key? key}) : super(key: key);

  @override
  State<PostulacionView> createState() => _PostulacionViewState();
}

class _PostulacionViewState extends State<PostulacionView> {
  int? _selectedtypesProject;
  bool temp = true;

  List<dynamic> _selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    final postulacionProvider = Provider.of<PostulacionesFormProvider>(context);

    final convocatoriasProvider = Provider.of<ConvocatoriaProvider>(context);

    final convocatoriasLast = convocatoriasProvider.lastConvocatoria;

    final usersProvider = Provider.of<UsersProvider>(context);

    final users = usersProvider.users;

    final typesProjects = convocatoriasProvider.typesProjets;

    final _itemsUsers = users
        .map((resource) => MultiSelectItem<Profile>(
            resource, resource.nombre + ' (' + resource.email + ')'))
        .toList();

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: postulacionProvider.formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crear Postulación',
                  style: GoogleFonts.quicksand(
                      fontSize: 24,
                      color: const Color(0xFF001B34),
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),
                // Basics
                CardDashboard(
                  title: 'Información basica',
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ejemplo:  Proyecto',
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
                            postulacionProvider.nombreProyecto = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        maxLines: 12,
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Justificación del proyecto',
                          label: 'Justificación',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese una justificación';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            postulacionProvider.justificacion = value,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        maxLines: 12,
                        decoration: CustomInputs.formInputDashboardDecoration(
                          hint: 'Ingrese los requerimientos del proyecto',
                          label: 'Requerimientos',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese los requerimientos';
                          }
                          if (value.isEmpty) {
                            return 'El campo no puede estar vacío';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            postulacionProvider.requerimientos = value,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

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
                              selected: _selectedtypesProject == index,
                              onSelected: (selected) {
                                setState(() {
                                  temp = false;
                                  _selectedtypesProject = index;
                                });
                                postulacionProvider.tipoProyectoId =
                                    typesProjects[index].id;
                              },
                              label: Text(typesProjects[index].tipoProyecto),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                CardDashboard(
                  title: 'Equipo',
                  child: Column(
                    children: [
                      MultiSelectDialogField(
                        items: _itemsUsers,
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
                          "Agregar Equipo",
                          style: TextStyle(
                            color: Color(0xFF00ACC1),
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedUsers = results;
                        },
                        initialValue: _selectedUsers,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: ElevatedButton(
                          onPressed: () async {
                            postulacionProvider.convocatoriaId =
                                convocatoriasLast[0].id;

                            for (var item in _selectedUsers) {
                              postulacionProvider.equipo
                                  .add(EquipoRegister(id: item.id));
                            }

                            await postulacionProvider.resgisterPostulacion();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                            shadowColor:
                                MaterialStateProperty.all(Colors.indigo),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.save_outlined),
                              Text(' Registrar Postulación'),
                            ],
                          )),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
