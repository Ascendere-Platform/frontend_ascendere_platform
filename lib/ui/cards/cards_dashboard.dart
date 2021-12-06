import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDashboard extends StatelessWidget {
  const CardDashboard({
    Key? key,
    this.title,
    required this.child,
    this.width,
    this.icon,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double? width;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // margin: const EdgeInsets.all(8),
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
