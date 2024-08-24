import 'package:flutter/material.dart';


class MaterialButtonDesign extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final void Function() onTap;
  const MaterialButtonDesign({super.key, required this.text, required this.height, required this.width, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.purple, Colors.purple.shade300],
        ),
      ),
      child: MaterialButton(
        onPressed: onTap,
        height: height,
        minWidth: width,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child:  Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
