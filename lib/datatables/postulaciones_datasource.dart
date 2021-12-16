import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';

class PostualcionesDataSource extends DataTableSource {
  final List<PostulacionResponse> postulaciones;
  final BuildContext context;

  PostualcionesDataSource(this.postulaciones, this.context);

  @override
  DataRow getRow(int index) {
    final postulacion = postulaciones[index];

    final docente = postulaciones[index]
        .equipo
        .firstWhere((element) => element.cargo == 'GESTOR');

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(postulacion.nombreProyecto)),
        DataCell(Text(docente.nombre)),
        DataCell(Text(
          postulacion.convocatoria.nombreConvocatoria,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(postulacion.tipoProyecto.tipoProyecto)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => postulaciones.length;

  @override
  int get selectedRowCount => 0;
}
