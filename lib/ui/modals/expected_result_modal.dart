import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/expected_result_form.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class ExpectedResultModal extends StatefulWidget {
  const ExpectedResultModal({Key? key, this.expectedResult}) : super(key: key);

  final ResultadosEsperado? expectedResult;

  @override
  State<ExpectedResultModal> createState() => _ExpectedResultModalState();
}

class _ExpectedResultModalState extends State<ExpectedResultModal> {
  @override
  Widget build(BuildContext context) {
    final convocatoriaProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    final expectedResultProvider =
        Provider.of<ExpectedResultFormProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 500,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: expectedResultProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nuevo Resultado Esperado',
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
                  onChanged: (value) => expectedResultProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre del resultado';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre de la Resultado',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) =>
                      expectedResultProvider.description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la descripción del resultado';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Descripción del resultado',
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
                      expectedResultProvider.score = double.parse(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el puntaje minimo del resultado';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Puntaje minimo del resultado',
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
                      final validForm = expectedResultProvider.validateForm();
                      if (!validForm) return;

                      try {
                        await convocatoriaProvider.registerExpectedResult(
                          expectedResultProvider.name,
                          expectedResultProvider.description,
                          expectedResultProvider.score,
                        );
                        NotificationsService.showSnackbar(
                            'Resultado : ${expectedResultProvider.name} creado');
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo crear el resultado esperado');
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
