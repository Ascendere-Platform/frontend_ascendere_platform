import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

class InfoUserView extends StatefulWidget {
  const InfoUserView({Key? key}) : super(key: key);

  @override
  State<InfoUserView> createState() => _InfoUserViewState();
}

class _InfoUserViewState extends State<InfoUserView> {
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
                'Datos del Usuario',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}
