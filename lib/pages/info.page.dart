import 'package:flutter/material.dart';
import 'package:test_app/components/shared/button.component.dart';

const baseLife = 40;
const maxLife = 100;
const minLife = 10;

const basePlayers = 4;
const maxPlayers = 6;
const minPlayers = 2;

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade700,
            Colors.red.shade900,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.grey.shade900.withAlpha(120),
                ),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade900.withAlpha(140),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Game Details',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Swipe left and right on your player card to get to commander damage. Damage on the other player cards is the damage you have given to them. \n\nSwipe up and down to get to your player details. There you can change your color and add/remove counters. Any counters you have will then appear on your screen as reference. \n\nTap the center circle to open the game options. \n\nGood luck and have fun!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade300,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonComponent(
                        shouldAnimate: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.grey.shade300,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
