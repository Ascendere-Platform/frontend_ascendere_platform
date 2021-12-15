import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';

import 'package:frontend_ascendere_platform/ui/cards/cards_convocatorias.dart';

class PostulacionView extends StatefulWidget {
  const PostulacionView({Key? key}) : super(key: key);

  @override
  State<PostulacionView> createState() => _PostulacionViewState();
}

class _PostulacionViewState extends State<PostulacionView> {
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
                'Postular',
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
