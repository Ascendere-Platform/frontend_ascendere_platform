import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/providers/postulaciones/postulaciones_provider.dart';
import 'package:frontend_ascendere_platform/providers/postulaciones/cronograma_provider.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/models/http/hito_responde.dart';
import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_icon_button_text.dart';
import 'package:frontend_ascendere_platform/ui/buttons/custom_icon_button_text_color.dart';
import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';

class PostualcionInfoView extends StatefulWidget {
  const PostualcionInfoView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _PostualcionInfoViewState createState() => _PostualcionInfoViewState();
}

class _PostualcionInfoViewState extends State<PostualcionInfoView> {
  PostulacionResponse? postu;
  List<Hito>? hitos;

  @override
  void initState() {
    super.initState();
    final postuProvider =
        Provider.of<PostulacionesProvider>(context, listen: false);

    final hitosProvider =
        Provider.of<CronogramaProvider>(context, listen: false);

    postuProvider.getPostulacionId(widget.id).then((postuDB) {
      if (postuDB != null) {
        hitosProvider.getHitosId(postuDB.id).then((hitosDB) {
          setState(() {
            hitos = hitosDB;
            postu = postuDB;
          });
        });
      } else {
        NavigationService.replaceTo('/dashboard/postulaciones');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    postu = null;
    hitos = null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Postulación',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              if (postu == null)
                CardDashboard(
                  child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              if (postu != null)
                _PostulacionViewBody(postu: postu!, hitos: hitos),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostulacionViewBody extends StatelessWidget {
  const _PostulacionViewBody({
    Key? key,
    required this.postu,
    required this.hitos,
  }) : super(key: key);

  final PostulacionResponse postu;
  final List<Hito>? hitos;

  @override
  Widget build(BuildContext context) {
    return Table(
      // columnWidths: const {0: FixedColumnWidth(600)},
      children: [
        TableRow(children: [
          _InfoPostualcionView(postu: postu, hitos: hitos),
          // _AvatarContainer(),
        ])
      ],
    );
  }
}

class _InfoPostualcionView extends StatelessWidget {
  const _InfoPostualcionView(
      {Key? key, required this.postu, required this.hitos})
      : super(key: key);

  final PostulacionResponse postu;
  final List<Hito>? hitos;

  @override
  Widget build(BuildContext context) {
    final validateDate = DateTime.parse("0001-01-01 00:00:00.000Z");

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Información básica',
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
                horizontalInside: BorderSide(
                    width: 0.3,
                    color: Colors.grey.shade500,
                    style: BorderStyle.solid),
                verticalInside: BorderSide(
                    width: 0.3,
                    color: Colors.grey.shade500,
                    style: BorderStyle.solid)),
            columnWidths:
                (size.width > 700) ? const {0: FixedColumnWidth(200)} : null,
            children: [
              TableRow(children: [
                const TittleTableRow(text: 'Nombre del proyecto'),
                ContentTableRow(text: postu.nombreProyecto),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Gestor del proyecto'),
                ContentTableRow(
                  text: postu.equipo
                      .firstWhere((element) => element.cargo == 'GESTOR')
                      .nombre,
                ),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Convocatoria'),
                ContentTableRow(text: postu.convocatoria.nombreConvocatoria),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Tipo de proyecto'),
                ContentTableRow(text: postu.tipoProyecto.tipoProyecto),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Fecha de postualción'),
                ContentTableRow(
                    text:
                        DateFormat('EEEE, MMMM dd').format(postu.fechaInicio)),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Fecha de actualización'),
                ContentTableRow(
                  text: (postu.fechaPublicacion! == validateDate)
                      ? 'S/N'
                      : DateFormat('EEEE, MMMM dd')
                          .format(postu.fechaPublicacion!),
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Información del Equipo',
          child: Wrap(
            spacing: 5,
            children: List.generate(
              postu.equipo.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: Text(postu.equipo[index].nombre[0]),
                    ),
                    label: Text(postu.equipo[index].nombre),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Información del proyecto',
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
                horizontalInside: BorderSide(
                    width: 0.3,
                    color: Colors.grey.shade500,
                    style: BorderStyle.solid),
                verticalInside: BorderSide(
                    width: 0.3,
                    color: Colors.grey.shade500,
                    style: BorderStyle.solid)),
            columnWidths:
                (size.width > 700) ? const {0: FixedColumnWidth(200)} : null,
            children: [
              TableRow(children: [
                const TittleTableRow(text: 'Justificación'),
                ContentTableRow(text: postu.justificacion),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Alcance'),
                ContentTableRow(
                  text: postu.alcance,
                ),
              ]),
              // TableRow(children: [
              //   const TittleTableRow(text: 'Requerimientos'),
              //   ContentTableRow(text: postu.requerimientos),
              // ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Requerimientos',
          child: Text(
            postu.requerimientos,
            style: CustomLabels.h2.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 20),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Cronograma',
          child: (hitos == null)
              ? Text(
                  'Sin cronograma',
                  style: CustomLabels.h2.copyWith(fontSize: 14),
                )
              : SizedBox(
                  height: 200 * double.parse(hitos!.length.toString()),
                  child: ListView.builder(
                    itemCount: hitos!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            border: TableBorder(
                                horizontalInside: BorderSide(
                                    width: 0.3,
                                    color: Colors.grey.shade500,
                                    style: BorderStyle.solid),
                                verticalInside: BorderSide(
                                    width: 0.3,
                                    color: Colors.grey.shade500,
                                    style: BorderStyle.solid)),
                            columnWidths: (size.width > 700)
                                ? const {0: FixedColumnWidth(200)}
                                : const {1: FixedColumnWidth(210)},
                            children: [
                              TableRow(children: [
                                const TittleTableRow(text: 'Hito'),
                                ContentTableRow(text: hitos![index].nombreHito),
                              ]),
                              TableRow(children: [
                                const TittleTableRow(text: 'Entregables'),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Wrap(
                                    children: List.generate(
                                      hitos![index].entregables.length,
                                      (indexTemp) {
                                        return SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            '${indexTemp + 1} : ' +
                                                hitos![index]
                                                    .entregables[indexTemp]
                                                    .toString(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                const TittleTableRow(text: 'Fecha de inicio'),
                                ContentTableRow(
                                    text: DateFormat('EEEE, MMMM dd')
                                        .format(hitos![index].fechaInicio)),
                              ]),
                              TableRow(children: [
                                const TittleTableRow(text: 'Fecha de fin'),
                                ContentTableRow(
                                    text: DateFormat('EEEE, MMMM dd')
                                        .format(hitos![index].fechaFin)),
                              ]),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            CustomIconButtonText(
              disable: postu.estado!,
              onPressed: () async {
                await Provider.of<PostulacionesProvider>(context, listen: false)
                    .approvedPostulacion(postu.id);
                NavigationService.naviageTo('/dashboard/postulaciones');
              },
              icon: Icons.check,
              text: 'Aprobar',
            ),
            const SizedBox(width: 8),
            CustomIconButtonTextColor(
              onPressed: () {
                NavigationService.naviageTo('/dashboard/postulaciones');
              },
              icon: Icons.cancel,
              text: 'Cancelar',
            ),
            const Spacer(),
          ],
        )
      ],
    );
  }
}

class ContentTableRow extends StatelessWidget {
  const ContentTableRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: CustomLabels.h2.copyWith(fontSize: 14),
      ),
    );
  }
}

class TittleTableRow extends StatelessWidget {
  const TittleTableRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style:
            CustomLabels.h2.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }
}
