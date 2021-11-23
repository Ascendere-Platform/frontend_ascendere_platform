import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';
import 'package:frontend_ascendere_platform/providers/register_form_provider.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_outlined.dart';
import 'package:frontend_ascendere_platform/ui/buttons/link_text.dart';
import 'package:frontend_ascendere_platform/ui/inputs/custom_inputs.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: registerFormProvider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Nueva cuenta',
                        style: GoogleFonts.quicksand(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // User
                    TextFormField(
                      onChanged: (value) => registerFormProvider.name = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su nombre';
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su nombre',
                          label: 'Nombre',
                          icon: Icons.supervised_user_circle_sharp),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      onChanged: (value) =>
                          registerFormProvider.lastName = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su apellido';
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su apellido',
                          label: 'Apellido',
                          icon: Icons.supervised_user_circle_sharp),
                    ),

                    const SizedBox(height: 20),

                    // Email
                    TextFormField(
                      onChanged: (value) => registerFormProvider.email = value,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Correo electrónico no válido';
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese un correo electrónico',
                          label: 'Correo electrónico',
                          icon: Icons.email),
                    ),

                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      onChanged: (value) =>
                          registerFormProvider.password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese la contraseña';
                        }
                        if (value.length < 6) {
                          return 'La contraseña debe ser de 6 caracteres';
                        }
                        return null;
                      },
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: '********',
                          label: 'Contraseña',
                          icon: Icons.lock_outline),
                    ),

                    const SizedBox(height: 20),
                    CustomOutlinedButton(
                      onPressed: () {
                        final validForm = registerFormProvider.validateForm();
                        if (!validForm) return;

                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);

                        authProvider.register(
                            registerFormProvider.email,
                            registerFormProvider.password,
                            registerFormProvider.name,
                            registerFormProvider.lastName);
                      },
                      text: 'Crear Cuenta',
                    ),

                    const SizedBox(height: 20),
                    LinkText(
                      text: 'Ir a login',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Flurorouter.loginRoute);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
