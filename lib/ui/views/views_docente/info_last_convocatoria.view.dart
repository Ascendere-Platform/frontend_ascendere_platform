import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/models/http/convocatoria_register.dart';
import 'package:frontend_ascendere_platform/models/http/convocatoria_response.dart';

import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';

class ConvocatoriaInfoView extends StatefulWidget {
  const ConvocatoriaInfoView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ConvocatoriaInfoViewState createState() => _ConvocatoriaInfoViewState();
}

class _ConvocatoriaInfoViewState extends State<ConvocatoriaInfoView> {
  ConvocatoriaRegister? conv;
  ConvocatoriaResponse? convResp;

  @override
  void initState() {
    super.initState();
    final convProvider =
        Provider.of<ConvocatoriaProvider>(context, listen: false);

    convProvider.getConvocatoriasId(widget.id).then((convDB) {
      if (convDB != null) {
        convResp = convDB;
        setState(() {
          convResp = convDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard/convocatorias');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    convResp = null;
    conv = null;
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
                'Convocatoria',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 10),
              if (convResp == null)
                CardDashboard(
                  child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              if (convResp != null) _ConvocatoriaViewBody(conv: convResp!),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConvocatoriaViewBody extends StatelessWidget {
  const _ConvocatoriaViewBody({
    Key? key,
    required this.conv,
  }) : super(key: key);

  final ConvocatoriaResponse conv;

  @override
  Widget build(BuildContext context) {
    return Table(
      // columnWidths: const {0: FixedColumnWidth(600)},
      children: [
        TableRow(children: [
          _InfoPostualcionView(conv: conv),
          // _AvatarContainer(),
        ])
      ],
    );
  }
}

class _InfoPostualcionView extends StatelessWidget {
  const _InfoPostualcionView({Key? key, required this.conv}) : super(key: key);

  final ConvocatoriaResponse conv;

  @override
  Widget build(BuildContext context) {
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
                const TittleTableRow(text: 'Nombre'),
                ContentTableRow(text: conv.nombreConvocatoria),
              ]),
              TableRow(children: [
                const TittleTableRow(text: 'Periodo'),
                ContentTableRow(text: conv.periodoConvocatoria),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Antecedentes',
          child: Text(
            conv.antecedentes,
            style: CustomLabels.h2.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
            hasMargin: false,
            width: double.infinity,
            title: 'Resultados Esperados',
            child: Wrap(
              children: List.generate(
                conv.resultadosEsperados.length,
                (indexTemp) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        '${indexTemp + 1} : ' +
                            conv.resultadosEsperados[indexTemp]
                                .descripcionResultado,
                      ),
                    ),
                  );
                },
              ),
            )),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Objetivos',
          child: Text(
            conv.objetivos,
            style: CustomLabels.h2.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Tipos de Proyecto',
          child: Wrap(
            spacing: 5,
            children: List.generate(
              conv.tiposProyectos.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: Chip(
                    label: Text(conv.tiposProyectos[index].tipoProyecto),
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
          title: 'Lineas Estratégicas',
          child: SizedBox(
            height:
                100 * double.parse(conv.anexosConvocatoria.length.toString()),
            child: ListView.builder(
              itemCount: conv.anexosConvocatoria.length,
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
                      columnWidths: const {0: FixedColumnWidth(100)},
                      children: [
                        TableRow(children: [
                          const TittleTableRow(text: 'Linea'),
                          ContentTableRow(
                              text: conv.lineasEstrategicas[index].nombreLinea),
                        ]),
                        TableRow(children: [
                          const TittleTableRow(text: 'Descripción'),
                          ContentTableRow(
                              text: conv
                                  .lineasEstrategicas[index].descripcionLinea),
                        ]),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Recursos',
          child: SizedBox(
            height:
                60 * double.parse(conv.anexosConvocatoria.length.toString()),
            child: ListView.builder(
              itemCount: conv.anexosConvocatoria.length,
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
                      columnWidths: const {0: FixedColumnWidth(100)},
                      children: [
                        TableRow(children: [
                          const TittleTableRow(text: 'Nombre'),
                          ContentTableRow(
                              text: conv
                                  .recursosConvocatoria[index].nombreRecurso),
                        ]),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        CardDashboard(
          hasMargin: false,
          width: double.infinity,
          title: 'Anexos',
          child: SizedBox(
            height:
                100 * double.parse(conv.anexosConvocatoria.length.toString()),
            child: ListView.builder(
              itemCount: conv.anexosConvocatoria.length,
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
                      columnWidths: const {0: FixedColumnWidth(100)},
                      children: [
                        TableRow(children: [
                          const TittleTableRow(text: 'Nombre'),
                          ContentTableRow(
                              text: conv.anexosConvocatoria[index].nombreAnexo),
                        ]),
                        TableRow(children: [
                          const TittleTableRow(text: 'Links'),
                          ContentTableRow(
                              text: conv.anexosConvocatoria[index].link),
                        ]),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
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
