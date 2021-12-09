import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';
import 'package:frontend_ascendere_platform/models/http/profile.dart';

class ResourcesDataSource extends DataTableSource {
  final List<RecursosConvocatoria> users;

  ResourcesDataSource(this.users);

  @override
  DataRow getRow(int index) {
    final user = users[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        // DataCell(Text(user.nombre)),
        // DataCell(Text(user.email)),
        DataCell(Text(user.id)),
        DataCell(
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
