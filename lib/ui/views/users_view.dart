import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/datatables/test.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/datatables/users_datasource.dart';

import 'package:frontend_ascendere_platform/providers/users_provider.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource = UsersDataSource(usersProvider.users);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usuarios',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnIndex,
            columns: [
              DataColumn(
                  label: const Text('Nombre'),
                  onSort: (colIndex, _) {
                    usersProvider.sortColumnIndex = colIndex;
                    usersProvider.sort<String>((user) => user.nombre);
                  }),
              DataColumn(
                  label: const Text('Email'),
                  onSort: (colIndex, _) {
                    usersProvider.sortColumnIndex = colIndex;
                    usersProvider.sort<String>((user) => user.email);
                  }),
              const DataColumn(label: Text('UID')),
              const DataColumn(label: Text('Acciones')),
            ],
            source: usersDataSource,
            onPageChanged: (page) {},
          ),
        ),
      ],
    );
  }
}
