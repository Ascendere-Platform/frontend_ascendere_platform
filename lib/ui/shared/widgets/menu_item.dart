import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
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
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.isActive
                        ? const Color(0xFF00ACC1)
                        : const Color(0xFF667685),
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.text,
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: widget.isActive
                          ? const Color(0xFF00ACC1)
                          : const Color(0xFF667685),
                      fontWeight:
                          widget.isActive ? FontWeight.bold : FontWeight.normal,
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
