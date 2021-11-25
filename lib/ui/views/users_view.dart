import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usuarios',
            style: GoogleFonts.quicksand(
                fontSize: 24,
                color: const Color(0xFF001B34),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
        
        ],
      ),
    );
  }
}
