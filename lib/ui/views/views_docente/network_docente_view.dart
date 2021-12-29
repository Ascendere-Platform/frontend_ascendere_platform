import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/datatables/docentes_datasource.dart';
import 'package:frontend_ascendere_platform/providers/users_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkView extends StatefulWidget {
  const NetworkView({Key? key}) : super(key: key);

  @override
  State<NetworkView> createState() => _NetworkViewState();
}

class _NetworkViewState extends State<NetworkView> {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource = DocentesDataSource(usersProvider.users, context);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Red de Docentes',
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
              const DataColumn(label: Text('Imagen')),
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
              // const DataColumn(label: Text('Seguir')),
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
