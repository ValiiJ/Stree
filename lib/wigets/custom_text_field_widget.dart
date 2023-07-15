import 'package:flutter/material.dart';

class CustomTextFiledWidget extends StatelessWidget {
  const CustomTextFiledWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.fillColor,
    required this.validator,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final Color? fillColor;
  final Function(String) validator;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller:
          controller, // Kontrolleri i fushës së tekst-it që pranon vlerat e shkruara nga përdoruesi
      decoration: InputDecoration(
        label: Text(
            '$label'), // Etiketa e fushës së tekst-it që shfaqet mbi fushën
        fillColor: fillColor,
        // Ngjyra e prapavijës së fushës së tekst-it
      ),
      validator: (value) => validator(
          value ?? ''), // Funksioni që verifikon vlerat e fushës së tekst-it
    );
  }
}
