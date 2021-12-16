import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDashboard extends StatelessWidget {
  const CardDashboard({
    Key? key,
    this.title,
    required this.child,
    this.width,
    this.icon,
    this.hasMargin = true,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double? width;
  final IconData? icon;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: width,
      margin: (size.width > 1000 && hasMargin)
          ? const EdgeInsets.symmetric(horizontal: 200)
          : null,
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
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
            const SizedBox(height: 10),
          ],
          child,
          const SizedBox(height: 10),
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
