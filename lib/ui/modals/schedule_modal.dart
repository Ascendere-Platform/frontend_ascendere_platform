import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/postulaciones/cronograma_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class ScheduleModal extends StatefulWidget {
  const ScheduleModal({Key? key}) : super(key: key);

  @override
  State<ScheduleModal> createState() => _ScheduleModalState();
}

class _ScheduleModalState extends State<ScheduleModal> {
  TextEditingController dateinputFrom = TextEditingController();
  TextEditingController dateinputTo = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  List<String> _values = [];

  @override
  void initState() {
    dateinputFrom.text = "";
    dateinputTo.text = "";
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Widget buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _values.length; i++) {
      InputChip actionChip = InputChip(
        label: Text(_values[i]),
        elevation: 10,
        pressElevation: 5,
        onDeleted: () {
          _values.removeAt(i);

          setState(() {
            _values = _values;
          });
        },
      );

      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: actionChip,
      ));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cronogramaProvider =
        Provider.of<CronogramaProvider>(context, listen: false);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 536,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: cronogramaProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nuevo Hito',
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
                  onChanged: (value) => cronogramaProvider.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el nombre del Hito';
                    }
                  },
                  decoration: CustomInputs.loginInputDecoration(
                    hint: 'Nombre del hito',
                    label: 'Nombre',
                    icon: Icons.new_releases_outlined,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: textEditingController,
                  decoration: CustomInputs.loginInputDecorationAction(
                    hint: 'Entregables al finalzar el hito',
                    label: 'Entregables',
                    icon: Icons.new_releases_outlined,
                    onPress: () {
                      _values.add(textEditingController.text);
                      textEditingController.clear();

                      setState(() {
                        _values = _values;
                      });
                    },
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: (_values.isEmpty) ? 0 : 30,
                  child: buildChips(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: dateinputFrom,
                  style: const TextStyle(color: Colors.white),
                  decoration:
                      inputDecorarionDate("Seleccione la fecha de inicio"),
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2050),
                    ).then((date) {
                      if (date == null) return;
                      setState(() {
                        cronogramaProvider.fechaInicio = date;
                        dateinputFrom.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      });
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: dateinputTo,
                  style: const TextStyle(color: Colors.white),
                  decoration: inputDecorarionDate("Seleccione la fecha de fin"),
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2050),
                    ).then((date) {
                      if (date == null) return;
                      setState(() {
                        cronogramaProvider.fechaFin = date;
                        dateinputTo.text =
                            DateFormat('yyyy-MM-dd').format(date);
                      });
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: CustomOutlinedButton(
                    onPressed: () async {
                      final validForm = cronogramaProvider.validateForm();
                      if (!validForm) return;

                      cronogramaProvider.results = _values;

                      if (_values.isEmpty) {
                        NotificationsService.showSnackbarError(
                            'Ingrese los resutados esperados');
                        return;
                      }

                      if (cronogramaProvider.fechaFin == null &&
                          cronogramaProvider.fechaInicio == null) {
                        NotificationsService.showSnackbarError(
                            'Ingrese las fechas del hito');
                        return;
                      }

                      cronogramaProvider.addHito();

                      Navigator.of(context).pop();
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

  InputDecoration inputDecorarionDate(String text) {
    return InputDecoration(
      icon: const Icon(Icons.calendar_today, color: Colors.grey),
      labelText: text,
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
      ),
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
