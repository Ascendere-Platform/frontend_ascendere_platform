import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/models/http/postualcion_response.dart';
import 'package:frontend_ascendere_platform/providers/profile_provider.dart';
import 'package:frontend_ascendere_platform/ui/cards/cards_projects.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend_ascendere_platform/providers/postulaciones/postulaciones_provider.dart';

class MyPostulacionView extends StatefulWidget {
  const MyPostulacionView({Key? key}) : super(key: key);

  @override
  State<MyPostulacionView> createState() => _MyPostulacionViewState();
}

class _MyPostulacionViewState extends State<MyPostulacionView> {
  late List<PostulacionResponse> projects;

  @override
  void initState() {
    super.initState();
    Provider.of<PostulacionesProvider>(context, listen: false)
        .getPostulaciones();
  }

  @override
  Widget build(BuildContext context) {
    final postualcionesProvider = Provider.of<PostulacionesProvider>(context);
    // postualcionesProvider.getPostulaciones();

    final profileProvider = Provider.of<ProfileProvider>(context);

    final profile = profileProvider.profile;

    final projects = postualcionesProvider.postulaciones.where(
      (project) {
        for (var item in project.equipo) {
          if (item.id == profile!.id) {
            return true;
          }
        }
        return false;
      },
    ).toList();

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mis postualciones',
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: const Color(0xFF001B34),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              (projects.isEmpty)
                  ? SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.sentiment_dissatisfied,
                              size: 80,
                            ),
                            const SizedBox(height: 8 * 3),
                            Text(
                              'No tienes postulaciones activas',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: const Color(0xFF001B34),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Wrap(
                      spacing: 5,
                      children: List.generate(
                        projects.length,
                        (index) {
                          return Material(
                            child: InkWell(
                              onTap: () {
                                // NavigationService.naviageTo(
                                //     '/dashboard/convocatorias/${projects[index].id}');
                              },
                              child: CardProjects(
                                state: projects[index].estado!,
                                title: projects[index].nombreProyecto,
                                child: Row(
                                  children: [
                                    Text(
                                      'Gestor : ',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      projects[index]
                                          .equipo
                                          .firstWhere((element) =>
                                              element.cargo == 'GESTOR')
                                          .nombre,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                // width: 225,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
