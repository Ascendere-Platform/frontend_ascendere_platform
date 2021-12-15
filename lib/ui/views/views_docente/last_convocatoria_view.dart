import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/ui/cards/cards_convocatorias.dart';

class LastConvocatoriasView extends StatefulWidget {
  const LastConvocatoriasView({Key? key}) : super(key: key);

  @override
  State<LastConvocatoriasView> createState() => _LastConvocatoriasViewState();
}

class _LastConvocatoriasViewState extends State<LastConvocatoriasView> {
  @override
  Widget build(BuildContext context) {
    final convocatoriasProvider = Provider.of<ConvocatoriaProvider>(context);
    convocatoriasProvider.getConvocatorias();

    final convocatorias = convocatoriasProvider.convocatorias;

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Convocatoria Vigente',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 5,
                children: List.generate(
                  convocatorias.length,
                  (index) {
                    return Material(
                      // borderRadius: const BorderRadius.all(Radius.circular(4)),
                      // elevation: 3,
                      child: InkWell(
                        onTap: () {
                          NavigationService.naviageTo(
                              '/dashboard/convocatorias/${convocatorias[index].id}');
                        },
                        child: CardConvocatorias(
                          state: convocatorias[index].estado,
                          title: convocatorias[index].nombreConvocatoria,
                          child: Text(
                            DateFormat('EEEE, MMMM dd')
                                .format(convocatorias[index].fechaCreacion),
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                            ),
                          ),
                          // width: 225,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
