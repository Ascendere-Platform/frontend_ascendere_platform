import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/profile_provider.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    final profile = profileProvider.profile;

    final image = (profile == null)
        ? const Image(
            image: AssetImage('assets/avatar_temp.png'),
            width: 40,
            height: 40,
          )
        : FadeInImage.assetNetwork(
            placeholder: 'assets/avatar_temp.png',
            image: profile.avatar,
            fit: BoxFit.cover,
          );

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: image,
          ),
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
