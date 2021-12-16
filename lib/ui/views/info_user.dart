import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/providers/profile_provider.dart';
import 'package:frontend_ascendere_platform/providers/user_form_provider.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/profile.dart';

import 'package:frontend_ascendere_platform/ui/labels/custom_labels.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_dashboard.dart';

class InfoUserView extends StatefulWidget {
  const InfoUserView({Key? key}) : super(key: key);

  @override
  State<InfoUserView> createState() => _InfoUserViewState();
}

class _InfoUserViewState extends State<InfoUserView> {
  Profile? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<ProfileProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getProfile().then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState(() {
          user = userDB;
        });
      } else {
        NavigationService.replaceTo('/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Datos del Usuario',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              if (user == null)
                CardDashboard(
                  child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              if (user != null) const _UserViewBody()
            ],
          ),
        ),
      ],
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FixedColumnWidth(250)},
      children: [
        TableRow(children: [
          const _AvatarContainer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: const _UserViewForm(),
          ),
        ])
      ],
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    return CardDashboard(
      hasMargin: false,
      title: 'Información adicional',
      child: Form(
        key: userFormProvider.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: user.avatar,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Link del avatar',
                label: 'Avatar',
                icon: Icons.supervised_user_circle_outlined,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el enlace de la imagen';
                }
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(biografia: value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.biografia,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Biografía del Usuario',
                label: 'Biografía',
                icon: Icons.supervised_user_circle_outlined,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese una biografía';
                }
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(biografia: value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.banner,
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Link del banner',
                  label: 'Banner',
                  icon: Icons.image),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un banner';
                }
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(banner: value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.sitioWeb,
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Link del sitio web',
                  label: 'Sitio Web',
                  icon: Icons.travel_explore_rounded),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un sito web';
                }
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(sitioWeb: value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: user.ubicacion,
              decoration: CustomInputs.formInputDecoration(
                  hint: 'Ubicación del usuario',
                  label: 'Ubicación',
                  icon: Icons.location_on),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese una ubicación';
                }
                return null;
              },
              onChanged: (value) =>
                  userFormProvider.copyUserWith(ubicacion: value),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: ElevatedButton(
                  onPressed: () async {
                    await userFormProvider.updateUser();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    shadowColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.save_outlined),
                      Text(' Guardar'),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    final image = (user.avatar == '')
        ? const Image(image: AssetImage('assets/avatar_temp.png'))
        : FadeInImage.assetNetwork(
            height: 120,
            width: 120,
            placeholder: 'assets/avatar_temp.png',
            image: user.avatar,
            fit: BoxFit.cover,
          );

    return CardDashboard(
      hasMargin: false,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Perfil', style: CustomLabels.h2),
            const SizedBox(height: 20),
            Center(
              child: ClipOval(
                child: image,
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                user.nombre,
                style: CustomLabels.h2,
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                user.email,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
