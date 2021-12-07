import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_icon_button_text.dart';

class CardDashboardAction extends StatelessWidget {
  const CardDashboardAction({
    Key? key,
    required this.child,
    required this.onPressed,
    this.title,
    this.width,
    this.icon,
  }) : super(key: key);

  final String? title;
  final Widget child;
  final double? width;
  final IconData? icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: width,
      margin: (size.width > 1000)
          ? const EdgeInsets.symmetric(horizontal: 200)
          : null,
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (title != null) ...[
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title!,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
                CustomIconButtonText(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => onPressed(),
                    );
                  },
                  icon: Icons.add_outlined,
                  text: 'Crear',
                ),
              ],
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
