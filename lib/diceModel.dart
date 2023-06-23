import 'package:flutter/material.dart';
import 'dart:math';

class DiceModel {
  int diceCount = 5;
  int currentColorIndex = 0;
  List<Color> colors = [
    const Color.fromARGB(255, 226, 17, 31),
    const Color.fromARGB(255, 48, 148, 39),
    const Color.fromARGB(255, 87, 90, 223),
  ];

  List<int> currentDiceRolls = [];

  void rollDice(int numberOfDice) {
    currentDiceRolls =
        List.generate(numberOfDice, (index) => Random().nextInt(6) + 1);
  }

  void changeColor() {
    currentColorIndex = (currentColorIndex + 1) % colors.length;
  }
}
