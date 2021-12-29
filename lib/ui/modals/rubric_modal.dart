import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/rubric_form.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class RubricModal extends StatefulWidget {
  const RubricModal({Key? key, this.rubric}) : super(key: key);

  final RubricasConvocatoria? rubric;

  @override
  State<RubricModal> createState() => _RubricModalState();
}

class _RubricModalState extends State<RubricModal> {
  @override
  Widget build(BuildContext context) {
    final convocatoriaProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    final rubricProvider =
        Provider.of<RubricFormProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 500,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: rubricProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nueva Rúbrica',
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
                  onChanged: (value) => rubricProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre de la rúbrica';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre de la Rúbrica',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => rubricProvider.description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la descripción de la Rúbrica';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Descripción de la Rúbrica',
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
                      rubricProvider.score = double.parse(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el puntaje minimo de la rúbrica';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Puntaje minimo de la Rúbrica',
                    label: 'Puntaje',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      final validForm = rubricProvider.validateForm();
                      if (!validForm) return;

                      try {
                        await convocatoriaProvider.registerRubric(
                          rubricProvider.name,
                          rubricProvider.description,
                          rubricProvider.score,
                        );
                        NotificationsService.showSnackbar(
                            'Rúbrica : ${rubricProvider.name} creado');
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo crear la rúbrica');
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
