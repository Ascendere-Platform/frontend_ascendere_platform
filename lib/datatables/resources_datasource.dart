import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/resources_provider.dart';

import 'package:frontend_ascendere_platform/models/http/resource_response.dart';

import 'package:frontend_ascendere_platform/ui/modals/resources_modal.dart';

class ResourcesDataSource extends DataTableSource {
  final List<ResourceResponse> resources;
  final BuildContext context;

  ResourcesDataSource(this.resources, this.context);

  @override
  DataRow getRow(int index) {
    final resourcesProvider =
        Provider.of<ResourcesProvider>(context, listen: false);

    final typesResources = resourcesProvider.types;

    final resource = resources[index];

    final indexTipo =
        typesResources.indexWhere((element) => element.id == resource.tipoid);

    // linkIMG
    final image = (resource.imagen == '' || resource.imagen == 'linkIMG')
        ? const Image(
            image: AssetImage('assets/no-image.jpg'),
            width: 40,
            height: 40,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'assets/no-image.jpg',
            width: 40,
            height: 40,
            image: resource.imagen!,
            fit: BoxFit.cover,
          );

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(ClipOval(
          child: image,
        )),
        DataCell(Text(resource.nombreRecurso)),
        DataCell(Text(resource.cantidadExistente.toString())),
        DataCell(Text(resource.cantidadDisponible.toString())),
        DataCell(Text((indexTipo < 0)
            ? 'No tiene tipo'
            : typesResources[indexTipo].nombreTipo)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) => ResourcesModal(
                      resource: resource,
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
              // IconButton(
              //   onPressed: () {
              //     final dialog = AlertDialog(
              //       title: const Text('¿Está seguro de borrarlo?'),
              //       content: Text(
              //           'Borrar definativametne ${resource.nombreRecurso}'),
              //       actions: [
              //         TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: const Text('No')),
              //         TextButton(
              //             onPressed: () {
              //               Provider.of<ResourcesProvider>(context,
              //                       listen: false)
              //                   .deleteResource(resource.id);
              //               Navigator.of(context).pop();
              //             },
              //             child: const Text('Si, borrar')),
              //         // SizedBox(width: 50,),
              //       ],
              //     );

              //     showDialog(context: context, builder: (_) => dialog);
              //   },
              //   icon: Icon(
              //     Icons.delete_outline,
              //     color: Colors.red.withOpacity(0.8),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => resources.length;

  @override
  int get selectedRowCount => 0;
}
