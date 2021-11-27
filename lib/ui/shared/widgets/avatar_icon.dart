import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final profile = Provider.of<ProfileProvider>(context).profile!;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: const Image(
            image: AssetImage('assets/avatar_temp.png'),
            fit: BoxFit.cover,
          ),
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
