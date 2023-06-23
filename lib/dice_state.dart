import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Dudo/diceModel.dart'; // ensure this import is correct

class DiceRoller extends StatefulWidget {
  final DiceModel diceModel;
  const DiceRoller({Key? key, required this.diceModel}) : super(key: key);

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>
    with SingleTickerProviderStateMixin {
  var isButtonDisabled = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  Timer? timer;
  int countdownSeconds = 0;

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
          widget.diceModel.changeColor(); // Change the color here
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

  void rollDice() {
    setState(() {
      isButtonDisabled = true;
    });

    _controller.forward();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: widget.diceModel.colors[widget.diceModel
          .currentColorIndex], // Use widget.diceModel here, // get color from diceModel
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                    turns: _animation,
                    child: Image.asset(
                      (widget.diceModel.currentDiceRolls.isNotEmpty &&
                              countdownSeconds != 15)
                          ? "lib/assets/images/dice-${widget.diceModel.currentDiceRolls.last}.png"
                          : "lib/assets/images/dice-0.png", // or any default image you have
                      width: 200,
                      height: 200,
                    )),
                const SizedBox(
                  height: 25,
                ),
                isButtonDisabled
                    ? Text(
                        "Tira denuevo en: $countdownSeconds segundos",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      )
                    : ElevatedButton(
                        onPressed: rollDice,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 67, 6, 101)),
                        child: const Text(
                          "Tira el dado",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
              ],
            ),
          ),
          Positioned(
            //3 circulos con
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
            //agregar dados
            top: 10.0,
            left: 10.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns all children to the left
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
                      constraints:
                          const BoxConstraints(), // Removes default padding of IconButton
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
                      constraints:
                          const BoxConstraints(), // Removes default padding of IconButton
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
