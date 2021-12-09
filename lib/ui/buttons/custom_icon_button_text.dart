import 'package:flutter/material.dart';

class CustomIconButtonText extends StatelessWidget {
  const CustomIconButtonText({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color = Colors.cyan,
    this.isFilled = false,
    this.disable = false,
  }) : super(key: key);

  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool disable;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        // shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: disable
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(color),
      ),
      onPressed: disable ? null : () => onPressed(),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8,),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
