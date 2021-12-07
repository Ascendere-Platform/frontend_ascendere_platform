import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/strategic_lines_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class StrategicLinesModal extends StatefulWidget {
  const StrategicLinesModal({Key? key, this.strategicLine}) : super(key: key);

  final LineasEstrategica? strategicLine;

  @override
  State<StrategicLinesModal> createState() => _StrategicLinesModalState();
}

class _StrategicLinesModalState extends State<StrategicLinesModal> {
  @override
  Widget build(BuildContext context) {
    final convocatoriaProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    final strategicLinesProvider =
        Provider.of<StrategicLinesFormProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 500,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: strategicLinesProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nueva Linea Estratégica',
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
                  // initialValue: widget.categoria?.nombre ?? '',
                  onChanged: (value) => strategicLinesProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre de la linea estratégica';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre de la Linea Estratégica',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) =>
                      strategicLinesProvider.description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la descripción de la linea estratégica';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Descripción de la Linea Estratégica',
                    label: 'Descripción',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      final validForm = strategicLinesProvider.validateForm();
                      if (!validForm) return;

                      try {
                        await convocatoriaProvider.registerAnnexe(
                            strategicLinesProvider.name,
                            strategicLinesProvider.description);
                        NotificationsService.showSnackbar(
                            'Linea Estratégica : ${strategicLinesProvider.name} creado');
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo crear la linea estratégica');
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
          color: Color(0xff0f2041),
          boxShadow: [
            BoxShadow(color: Colors.black26),
          ]);
}
