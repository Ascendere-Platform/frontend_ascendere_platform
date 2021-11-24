import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSeparator extends StatelessWidget {
  const TextSeparator({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: const Color(0xFF667685),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF667685),
            size: 22,
          ),
        ],
      ),
    );
  }
}
