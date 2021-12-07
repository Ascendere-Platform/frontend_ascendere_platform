import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/types_project_form_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class TypeProjectModal extends StatefulWidget {
  const TypeProjectModal({Key? key, this.rubric}) : super(key: key);

  final RubricasConvocatoria? rubric;

  @override
  State<TypeProjectModal> createState() => _TypeProjectModalState();
}

class _TypeProjectModalState extends State<TypeProjectModal> {
  @override
  Widget build(BuildContext context) {
    final convocatoriaProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    final typeProjectProvider =
        Provider.of<TypesProjectFormProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 500,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: typeProjectProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nuevo Tipo de Proyecto',
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
                  onChanged: (value) => typeProjectProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre del proyecto';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre deL Proyecto',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => typeProjectProvider.description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la descripción del proyecto';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Descripción del Proyecto',
                    label: 'Descripción',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) =>
                      typeProjectProvider.budget = double.parse(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el presupuesto del proyecto';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Presupuesto del Proyecto',
                    label: 'Presupuesto',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      final validForm = typeProjectProvider.validateForm();
                      if (!validForm) return;

                      try {
                        await convocatoriaProvider.registerTypeProject(
                          typeProjectProvider.name,
                          typeProjectProvider.description,
                          typeProjectProvider.budget,
                        );
                        NotificationsService.showSnackbar(
                            'Tipo de proyecto : ${typeProjectProvider.name} creado');
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo crear el tipo de proyecto');
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
