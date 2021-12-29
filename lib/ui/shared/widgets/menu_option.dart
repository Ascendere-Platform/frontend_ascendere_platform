import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuOption extends StatefulWidget {
  const MenuOption({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  State<MenuOption> createState() => _MenuOptionState();
}

class _MenuOptionState extends State<MenuOption> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
      child: Material(
        animationDuration: const Duration(milliseconds: 250),
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: const Color(0xFF667685),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
