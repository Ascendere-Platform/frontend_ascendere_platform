import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:frontend_ascendere_platform/providers/resources_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/resources_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/resource_response.dart';

import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';
import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class ResourcesModal extends StatefulWidget {
  const ResourcesModal({Key? key, this.resource}) : super(key: key);

  final ResourceResponse? resource;

  @override
  State<ResourcesModal> createState() => _ResourcesModalState();
}

class _ResourcesModalState extends State<ResourcesModal> {
  int? _selectedtypesProject;
  String? id;
  String name = '';
  String img = '';
  String typeId = '';
  int quantity = 0;

  bool temp = true;

  @override
  void initState() {
    super.initState();
    id = widget.resource?.id;
    name = widget.resource?.nombreRecurso ?? '';
    img = widget.resource?.imagen ?? '';
    typeId = widget.resource?.tipoid ?? '';
    quantity = widget.resource?.cantidadExistente ?? 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resourcesProvider =
        Provider.of<ResourcesProvider>(context, listen: false);

    final resoucesFormProvider =
        Provider.of<ResourcesFormProvider>(context, listen: false);

    final typesResources = resourcesProvider.types;

    if (id != null && temp) {
      _selectedtypesProject =
          typesResources.indexWhere((type) => type.id == typeId);
      resoucesFormProvider.typeId = typeId;
    }

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 580,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: resoucesFormProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.resource?.nombreRecurso ?? 'Nuevo Recurso',
                      style: CustomLabels.h2.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.resource?.nombreRecurso ?? '',
                  onChanged: (value) => resoucesFormProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre del recurso';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre del Recurso',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.resource?.imagen ?? '',
                  onChanged: (value) => resoucesFormProvider.img = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el enlace de enlace de la imagen';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Enlace de la imagen',
                    label: 'Imagen',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: (id != null) ? '0' : '',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) =>
                      resoucesFormProvider.quantity = int.parse(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la cantidad de recursos nuevos';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: (id != null)
                        ? 'Cantidad de recursos a aumentar'
                        : 'Cantidad de recursos',
                    label: (id != null) ? 'Cantidad a aumetnar' : 'Cantidad',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),

                // Types Projects
                CardDashboard(
                  title: 'Tipos de proyecto',
                  child: Column(children: [
                    Wrap(
                      spacing: 5,
                      children: List.generate(
                        typesResources.length,
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
                                resoucesFormProvider.typeId =
                                    typesResources[index].id;
                              },
                              label: Text(typesResources[index].nombreTipo),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      final validForm = resoucesFormProvider.validateForm();
                      if (!validForm) return;

                      try {
                        if (id != null) {
                          await resourcesProvider.updateResource(
                            id!,
                            resoucesFormProvider.name,
                            resoucesFormProvider.img,
                            resoucesFormProvider.quantity,
                            resoucesFormProvider.typeId,
                          );

                          NotificationsService.showSnackbar(
                              'Recurso : ${resoucesFormProvider.name} actualizado');

                          Navigator.of(context).pop();
                        } else {
                          await resourcesProvider.registerResource(
                            resoucesFormProvider.name,
                            resoucesFormProvider.img,
                            resoucesFormProvider.quantity,
                            resoucesFormProvider.typeId,
                          );
                          NotificationsService.showSnackbar(
                              'Recurso : ${resoucesFormProvider.name} creado');
                          Navigator.of(context).pop();
                        }

                        resoucesFormProvider.name = '';
                        resoucesFormProvider.img = '';
                        resoucesFormProvider.typeId = '';
                        resoucesFormProvider.quantity = 0;
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo guardar los cambios');
                      }
                    },
                    text: 'Guardar',
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color(0xff222E50),
          boxShadow: [
            BoxShadow(color: Colors.black26),
          ]);
}
