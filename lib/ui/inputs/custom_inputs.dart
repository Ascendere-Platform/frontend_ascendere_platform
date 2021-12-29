import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
      );

  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon,
  }) =>
      InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
      );

  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) =>
      InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
      );

  static InputDecoration formInputDashboardDecoration({
    required String hint,
    required String label,
    // required IconData icon,
  }) =>
      InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        // prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),
      );

  static InputDecoration loginInputDecorationAction({
    required String hint,
    required String label,
    required IconData icon,
    required Function onPress,
  }) =>
      InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3)),
          ),
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: () => onPress(),
            icon: const Icon(
              Icons.add_box,
              color: Colors.blue,
            ),
          ));
}
