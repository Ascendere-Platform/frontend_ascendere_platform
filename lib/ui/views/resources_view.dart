import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/ui/modals/resources_modal.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/resources_provider.dart';

import 'package:frontend_ascendere_platform/datatables/resources_datasource.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_icon_button_text.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';

class ResourcesView extends StatefulWidget {
  const ResourcesView({Key? key}) : super(key: key);

  @override
  State<ResourcesView> createState() => _ResourcesViewState();
}

class _ResourcesViewState extends State<ResourcesView> {
  @override
  Widget build(BuildContext context) {
    final resourcesProvider = Provider.of<ResourcesProvider>(context);

    final usersDataSource =
        ResourcesDataSource(resourcesProvider.resources, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'Gestionar Recursos',
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: PaginatedDataTable(
              columns: [
                const DataColumn(label: Text('Imagen')),
                DataColumn(
                    label: const Text('Nombre'),
                    onSort: (colIndex, _) {
                      resourcesProvider.sortColumnIndex = colIndex;
                      resourcesProvider
                          .sort<String>((user) => user.nombreRecurso);
                    }),
                const DataColumn(label: Text('Cant. Existente')),
                const DataColumn(label: Text('Cant. Disponible')),
                DataColumn(
                    label: const Text('Tipo'),
                    onSort: (colIndex, _) {
                      resourcesProvider.sortColumnIndex = colIndex;
                      resourcesProvider.sort<String>((user) => user.tipoid);
                    }),
                const DataColumn(label: Text('Acciones')),
              ],
              source: usersDataSource,
              onRowsPerPageChanged: (value) {
                setState(() {});
              },
              header: const Text(
                'Tabla de Recursos',
                maxLines: 2,
              ),
              actions: [
                CustomIconButtonText(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => const ResourcesModal(resource: null),
                    );
                  },
                  icon: Icons.add_outlined,
                  text: 'Crear',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
