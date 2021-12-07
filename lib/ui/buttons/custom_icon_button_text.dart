import 'package:flutter/material.dart';

class CustomIconButtonText extends StatelessWidget {
  const CustomIconButtonText({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color = Colors.cyan,
    this.isFilled = false,
  }) : super(key: key);

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          // shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(color)),
      onPressed: () => onPressed(),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
