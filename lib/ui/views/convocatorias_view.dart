import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConvocatoriasView extends StatefulWidget {
  const ConvocatoriasView({Key? key}) : super(key: key);

  @override
  State<ConvocatoriasView> createState() => _ConvocatoriasViewState();
}

class _ConvocatoriasViewState extends State<ConvocatoriasView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 0),
          Text(
            'Hola, bienvenido!',
            style: GoogleFonts.quicksand(
                fontSize: 14,
                color: const Color(0xFF001B34),
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
