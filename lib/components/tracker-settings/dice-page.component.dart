import 'dart:math';

import 'package:flutter/material.dart';

import '../shared/button.component.dart';
import '../shared/radial.component.dart';

const double radius = 80;
const double buttonSize = 64;

const List<int> dice = [4, 6, 8, 10, 12, 20];

class DicePage extends StatelessWidget {
  const DicePage({
    super.key,
    required this.rollDice,
    required this.goBack,
  });

  final ValueChanged<int> rollDice;
  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Stack(
          children: [
            for (int index = 0; index < dice.length; index++)
              RadialComponent(
                angle: ((2 * pi) / dice.length) * index,
                radius: radius,
                child: SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: ButtonComponent(
                    onPressed: () => {rollDice(dice[index])},
                    child: Center(
                      child: Transform.rotate(
                        angle: (pi * 0.5) + (2 * (pi / 6) * index),
                        child: Image(
                          image: AssetImage('assets/d${dice[index]}.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Center(
              child: IconButton(
                iconSize: 36,
                onPressed: goBack,
                color: Colors.grey.shade200,
                icon: Icon(Icons.home_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
