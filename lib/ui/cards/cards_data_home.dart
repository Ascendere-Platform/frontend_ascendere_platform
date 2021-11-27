import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDataHome extends StatelessWidget {
  const CardDataHome({
    Key? key,
    this.title,
    required this.child,
    this.width,
    required this.icon,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double? width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title!,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
          ],
          child,
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'XI Convocatoria',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                icon,
                color: const Color(0xFF667685),
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ]);
}
