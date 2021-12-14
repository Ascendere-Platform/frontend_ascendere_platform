import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/models/http/profile.dart';

import 'package:frontend_ascendere_platform/ui/modals/user_modal.dart';

class UsersDataSource extends DataTableSource {
  final List<Profile> users;
  final BuildContext context;

  UsersDataSource(this.users, this.context);

  @override
  DataRow getRow(int index) {
    final user = users[index];

    final image = (user.avatar == '')
        ? const Image(
            image: AssetImage('assets/no-image.jpg'),
            width: 40,
            height: 40,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'assets/no-image.jpg',
            width: 40,
            height: 40,
            image: user.avatar,
            fit: BoxFit.cover,
          );

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(ClipOval(
          child: image,
        )),
        DataCell(Text(user.nombre)),
        DataCell(Text(user.email)),
        DataCell(Text(user.rol.nombreRol)),
        DataCell(
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (_) => UserModal(
                  resource: user,
                ),
              );
            },
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
