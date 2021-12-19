import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardProjects extends StatelessWidget {
  const CardProjects({
    Key? key,
    required this.title,
    required this.child,
    required this.state,
    this.width,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double? width;
  final bool state;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: (size.width < 700) ? width : 325,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              title!,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.quicksand(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'Estado:',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 80,
                height: 24,
                decoration: buildBoxDecorationState(),
                child: Center(
                  child: (state)
                      ? Text(
                          'Aprobado',
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            color: const Color(0xFF667684),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          'Creada',
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            color: const Color(0xFF667684),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              if (state) ...[],
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ]);

  BoxDecoration buildBoxDecorationState() => BoxDecoration(
          color: const Color(0xFFDAEDFF),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ]);
}
