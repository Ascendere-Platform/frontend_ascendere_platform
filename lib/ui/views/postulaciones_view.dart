import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/postulaciones/postulaciones_provider.dart';

import 'package:frontend_ascendere_platform/datatables/postulaciones_datasource.dart';

class PostulacionesView extends StatefulWidget {
  const PostulacionesView({Key? key}) : super(key: key);

  @override
  State<PostulacionesView> createState() => _PostulacionesViewState();
}

class _PostulacionesViewState extends State<PostulacionesView> {
  @override
  Widget build(BuildContext context) {
    final postualcionesProvider = Provider.of<PostulacionesProvider>(context);

    final postulacionesDataSource =
        PostualcionesDataSource(postualcionesProvider.postulaciones, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: PaginatedDataTable(
              sortAscending: postualcionesProvider.ascending,
              sortColumnIndex: postualcionesProvider.sortColumnIndex,
              columns: [
                DataColumn(
                    label: const Text('Nombre del proyecto'),
                    onSort: (colIndex, _) {
                      postualcionesProvider.sortColumnIndex = colIndex;
                      postualcionesProvider
                          .sort<String>((user) => user.nombreProyecto);
                    }),
                const DataColumn(label: Text('Gestor del proyecto')),
                DataColumn(
                    label: const Text('Convocatoria'),
                    onSort: (colIndex, _) {
                      postualcionesProvider.sortColumnIndex = colIndex;
                      postualcionesProvider.sort<String>(
                          (user) => user.convocatoria.nombreConvocatoria);
                    }),
                DataColumn(
                    label: const Text('Tipo de proyecto'),
                    onSort: (colIndex, _) {
                      postualcionesProvider.sortColumnIndex = colIndex;
                      postualcionesProvider.sort<String>(
                          (user) => user.tipoProyecto.tipoProyecto);
                    }),
                const DataColumn(label: Text('Acciones')),
              ],
              source: postulacionesDataSource,
              onRowsPerPageChanged: (value) {
                setState(() {});
              },
              header: const Text(
                'Listado de Postualciones',
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
