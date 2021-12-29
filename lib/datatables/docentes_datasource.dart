import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/models/http/profile.dart';

class DocentesDataSource extends DataTableSource {
  final List<Profile> users;
  final BuildContext context;

  DocentesDataSource(this.users, this.context);

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
            image: user.avatar!,
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
        // DataCell(Text((tempFollow!) ? 'Siguiendo' : 'No')),
        DataCell(
          ElevatedButton(
            onPressed: () async {
              // await userFormProvider.followDocente(user.id);
              // print('object ' + tempFollow.toString());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.indigo),
              shadowColor: MaterialStateProperty.all(Colors.indigo),
            ),
            child: const Text(' Seguir'),
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
