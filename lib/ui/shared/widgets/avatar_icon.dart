import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile!;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            image: DecorationImage(
              image: (profile.avatar == 'null')
                  ? const NetworkImage(
                      'https://images.unsplash.com/photo-1608889825205-eebdb9fc5806?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80')
                  : NetworkImage(profile.avatar),
              fit: BoxFit.cover,
            ),
          ),
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
