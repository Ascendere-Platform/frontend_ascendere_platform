import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';
import 'package:frontend_ascendere_platform/services/navigation_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
        DataCell(SizedBox(
          width: 250,
          child: Text(
            postulacion.convocatoria.nombreConvocatoria,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )),
        DataCell(Text(postulacion.tipoProyecto.tipoProyecto)),
        DataCell(
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 4),
            width: 92,
            height: 24,
            decoration: buildBoxDecorationState(),
            child: Center(
              child: (postulacion.estado!)
                  ? Text(
                      'Aprobado',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        color: const Color(0xFF667684),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      'No Aprobado',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        color: const Color(0xFF667684),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => NavigationService.naviageTo(
                    '/dashboard/postulaciones/${postulacion.id}'),
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecorationState() => BoxDecoration(
          color: const Color(0xFFDAEDFF),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ]);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => postulaciones.length;

  @override
  int get selectedRowCount => 0;
}
