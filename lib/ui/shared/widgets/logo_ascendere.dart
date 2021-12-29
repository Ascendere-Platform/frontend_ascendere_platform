import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AscendereLogo extends StatelessWidget {
  const AscendereLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Row(
        children: [
          Material(
            color: const Color(0xFF00ACC1),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                'assets/ascendere_logo_small.svg',
                color: Colors.white,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
