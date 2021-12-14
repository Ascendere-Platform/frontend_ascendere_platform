import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/models/http/profile.dart';
import 'package:frontend_ascendere_platform/providers/users_provider.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:frontend_ascendere_platform/providers/resources_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/resources_provider.dart';

import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined_button.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class UserModal extends StatefulWidget {
  const UserModal({Key? key, this.resource}) : super(key: key);

  final Profile? resource;

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  int? _selectedtypesProject;
  String? id;

  bool temp = true;

  @override
  void initState() {
    super.initState();
    id = widget.resource?.id;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resourcesProvider =
        Provider.of<UsersProvider>(context, listen: false);

    final roles = resourcesProvider.rol;

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          height: 580,
          width: 300,
          decoration: buildBoxDecoration(),
          child: Form(
            key: resourcesProvider.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.resource?.nombre ?? 'Nuevo Recurso',
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

                // Types Projects
                CardDashboard(
                  title: 'Roles',
                  child: Column(children: [
                    Wrap(
                      spacing: 5,
                      children: List.generate(
                        roles.length,
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
                                resourcesProvider.idRol = roles[index].id;
                              },
                              label: Text(roles[index].nombreRol),
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
                      final validForm = resourcesProvider.validateForm();
                      if (!validForm) return;

                      try {
                        if (id != null) {
                          await resourcesProvider.updateRol(
                            id!,
                            resourcesProvider.idRol,
                          );

                          NotificationsService.showSnackbar(
                              'Usuario : ${widget.resource?.nombre} actualizado');

                          Navigator.of(context).pop();
                        }
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
