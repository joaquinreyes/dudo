import 'package:flutter/material.dart';
import 'package:Dudo/diceModel.dart';
import 'dart:async';
import 'dart:math';

class DiceRoller4 extends StatefulWidget {
  final DiceModel diceModel;
  const DiceRoller4({Key? key, required this.diceModel}) : super(key: key);

  @override
  _DiceRollerState4 createState() => _DiceRollerState4();
}

class _DiceRollerState4 extends State<DiceRoller4>
    with SingleTickerProviderStateMixin {
  bool isButtonDisabled = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? timer;
  int countdownSeconds = 0;
  int dice1Value = 0;
  int dice2Value = 0;
  int dice3Value = 0;
  int dice4Value = 0;

  final rng = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.diceModel.rollDice(widget.diceModel.diceCount);
          _controller.reset();
          countdownSeconds = 15;
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
              countdownSeconds--;
            });

            if (countdownSeconds == 0) {
              timer.cancel();
              setState(() {
                isButtonDisabled = false;
              });
            }
          });
        }
      });

    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  void rollDice2() {
    setState(() {
      isButtonDisabled = true;
      // Update dice values
      dice1Value = rng.nextInt(6) + 1;
      dice2Value = rng.nextInt(6) + 1;
      dice3Value = rng.nextInt(6) + 1;
      dice4Value = rng.nextInt(6) + 1;

      // Update color
      widget.diceModel.currentColorIndex =
          (widget.diceModel.currentColorIndex + 1) %
              widget.diceModel.colors.length;
    });
    widget.diceModel.rollDice(widget.diceModel.diceCount);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.diceModel.colors[widget.diceModel.currentColorIndex],
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RotationTransition(
                      turns: _animation,
                      child: Image.asset(
                        "lib/assets/images/dice-$dice1Value.png", // Generate a random number for the dice image
                        width: 150,
                        height: 150,
                      ),
                    ),
                    RotationTransition(
                      turns: _animation,
                      child: Image.asset(
                        "lib/assets/images/dice-$dice2Value.png",
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RotationTransition(
                      turns: _animation,
                      child: Image.asset(
                        "lib/assets/images/dice-$dice3Value.png", // Generate a random number for the dice image
                        width: 150,
                        height: 150,
                      ),
                    ),
                    RotationTransition(
                      turns: _animation,
                      child: Image.asset(
                        "lib/assets/images/dice-$dice4Value.png",
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                isButtonDisabled
                    ? Text(
                        "Tira denuevo en: $countdownSeconds segundos",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      )
                    : ElevatedButton(
                        onPressed: rollDice2,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 67, 6, 101)),
                        child: const Text(
                          "Tira los dados",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: Row(
              children: widget.diceModel.colors.map((color) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Dados en la mesa",
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(7),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: widget.diceModel.diceCount > 1
                          ? () => setState(() => widget.diceModel.diceCount--)
                          : null,
                    ),
                    Text(
                      '${widget.diceModel.diceCount}',
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(7),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          setState(() => widget.diceModel.diceCount++),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
