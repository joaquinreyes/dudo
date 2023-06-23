import 'package:flutter/material.dart';
import 'package:Dudo/dice_state.dart';
import 'package:Dudo/dice_state2.dart';
import 'package:Dudo/dice_state3.dart';
import 'package:Dudo/dice_state4.dart';
import 'package:Dudo/dice_state5.dart';
import 'package:Dudo/diceModel.dart';

const startAlignment = MainAxisAlignment.start;

class GradientContainer extends StatelessWidget {
  GradientContainer(this.colors, {Key? key}) : super(key: key);
  final List<Color> colors;
  final DiceModel diceModel = DiceModel(); // Declare DiceModel here

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
        ),
        child: Scaffold(
          backgroundColor: Colors
              .transparent, // Make the Scaffold background transparent so that the Container gradient shows
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 67, 6, 101),
            bottom: const TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 0),
              labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              tabs: [
                Tab(text: '5 🎲'),
                Tab(text: '4 🎲'),
                Tab(text: '3 🎲'),
                Tab(text: '2 🎲'),
                Tab(text: '1 🎲'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DiceRoller5(diceModel: diceModel),
              DiceRoller4(diceModel: diceModel),
              DiceRoller3(diceModel: diceModel),
              DiceRoller2(diceModel: diceModel),
              DiceRoller(diceModel: diceModel),
            ],
          ),
        ),
      ),
    );
  }
}
