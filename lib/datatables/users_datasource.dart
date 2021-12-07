import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/models/http/profile.dart';

class UsersDataSource extends DataTableSource {
  final List<Profile> users;

  UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {
    final user = users[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(user.nombre)),
        DataCell(Text(user.email)),
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
