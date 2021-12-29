import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/annexes_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class AnnexesModal extends StatefulWidget {
  const AnnexesModal({Key? key, this.annexes}) : super(key: key);

  final AnexosConvocatoria? annexes;

  @override
  State<AnnexesModal> createState() => _AnnexesModalState();
}

class _AnnexesModalState extends State<AnnexesModal> {
  @override
  Widget build(BuildContext context) {
    final convocatoriaProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    final annexesProvider =
        Provider.of<AnnexesFormProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 500,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: annexesProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nuevo Anexo',
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
                  onChanged: (value) => annexesProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre del anexo';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre del Anexo',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => annexesProvider.link = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el link del anexo';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Link del Anexo',
                    label: 'Link',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      final validForm = annexesProvider.validateForm();
                      if (!validForm) return;

                      try {
                        await convocatoriaProvider.registerAnnexe(
                            annexesProvider.name, annexesProvider.link);
                        NotificationsService.showSnackbar(
                            'Anexo : ${annexesProvider.name} creado');
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        NotificationsService.showSnackbarError(
                            'No se pudo crear el anexo');
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
