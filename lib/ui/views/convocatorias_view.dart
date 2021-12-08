import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/ui/cards/cards_convocatorias.dart';

class ConvocatoriasView extends StatefulWidget {
  const ConvocatoriasView({Key? key}) : super(key: key);

  @override
  State<ConvocatoriasView> createState() => _ConvocatoriasViewState();
}

class _ConvocatoriasViewState extends State<ConvocatoriasView> {
  @override
  Widget build(BuildContext context) {
    final convocatoriasProvider =
        Provider.of<ConvocatoriaProvider>(context);
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
                'Convocatorias',
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
                    return CardConvocatorias(
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
