import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final FocusNode? focusNode;

  const CustomTextField({super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,  this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.purple,fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.purple[50],
        prefixIcon: Icon(prefixIcon, color: Colors.purple),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $labelText';
        }
        return null;
      },
    );
  }
}
