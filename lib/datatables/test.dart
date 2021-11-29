import 'package:flutter/material.dart';

class TestData extends DataTableSource {
  // final List<UserResponse> users;

  // UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {
    // final user = users[index];

    return DataRow.byIndex(
      index: index,

      cells: [
        DataCell(Text('user.nombre'), showEditIcon: true),
        DataCell(Text('user.email')),
        DataCell(Text('user.id')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
