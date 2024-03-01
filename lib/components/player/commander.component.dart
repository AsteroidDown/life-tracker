import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.model.dart';
import '../../states/tracker.state.dart';

class CommanderComponent extends StatelessWidget {
  const CommanderComponent({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
              decoration: BoxDecoration(
                color: player.color,
                borderRadius: BorderRadius.all(Radius.circular(48)),
              ),
              child: AnimatedDefaultTextStyle(
                curve: Curves.bounceInOut,
                duration: Duration(milliseconds: commanderPunchTime),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                  decoration: TextDecoration.none,
                  fontSize: trackerState.gaveCommander ? 36 : 32,
                ),
                child: Text('Commander'),
              ),
            ),
            // SizedBox(height: 12),
            // AnimatedDefaultTextStyle(
            //   curve: Curves.bounceInOut,
            //   duration: Duration(milliseconds: commanderPunchTime),
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: player.color,
            //     decoration: TextDecoration.none,
            //     fontSize: trackerState.gaveCommander ? 22 : 24,
            //   ),
            //   child: Text(
            //     'Damage Recieved',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
