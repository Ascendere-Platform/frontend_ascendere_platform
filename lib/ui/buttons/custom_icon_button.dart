import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.isDark = false,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (isDark) ? const Color(0xFF00ACC1) : const Color(0xFFF8F8F9),
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      elevation: 3,
      child: InkWell(
        onTap: () => onPressed(),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 40,
          width: 40,
          child: Icon(
            icon,
            color: (isDark) ? const Color(0xFFF8F8F9) : const Color(0xFF00ACC1),
          ),
        ),
      ),
    );
  }
}
