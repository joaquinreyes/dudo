import 'package:flutter/material.dart';
import 'package:Dudo/gradient_container.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    body: GradientContainer([
      Color.fromARGB(233, 255, 155, 155),
      Color.fromARGB(233, 164, 68, 165),
      Color.fromARGB(233, 151, 162, 71)
    ]),
  )));
}
