import 'package:flutter/material.dart';

class TextStyling extends StatelessWidget {
  const TextStyling(this.text, {super.key});
  final String text;
  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromARGB(233, 88, 13, 76),
          fontSize: 25,
          fontWeight: FontWeight.w700),
    );
  }
}
