import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Plataforma Ascendere',
              style: GoogleFonts.quicksand(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          (size.width < 1000)
              ? const SizedBox(height: 20)
              : const SizedBox(height: 0),
        ],
      ),
    );
  }
}
