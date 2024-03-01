import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/template.model.dart';
import '../../states/tracker.state.dart';
import '../player/player.component.dart';
import 'layouts.dart';

class ThreePlayers extends StatelessWidget {
  const ThreePlayers({Key? key, required this.template}) : super(key: key);

  final Template template;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    if (trackerState.template == null) {
      trackerState.setTemplate(template);
    }

    return Stack(
      children: [
        ThreePlayersLayoutOne(),
        IgnorePointer(
          ignoring: !trackerState.alternateLayout,
          child: AnimatedOpacity(
            duration: layoutDuration,
            opacity: trackerState.alternateLayout ? 1 : 0,
            child: ThreePlayersLayoutTwo(),
          ),
        ),
      ],
    );
  }
}

class ThreePlayersLayoutOne extends StatelessWidget {
  const ThreePlayersLayoutOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: RotatedBox(
              quarterTurns: 1,
              child: PlayerComponent(
                player: trackerState.players[0],
              ),
            ),
          ),
          SizedBox(width: playerDivide),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: PlayerComponent(
                      player: trackerState.players[1],
                    ),
                  ),
                ),
                SizedBox(height: playerDivide),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: PlayerComponent(
                      player: trackerState.players[2],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThreePlayersLayoutTwo extends StatelessWidget {
  const ThreePlayersLayoutTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: PlayerComponent(
                      player: trackerState.players[0],
                    ),
                  ),
                ),
                SizedBox(width: playerDivide),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: PlayerComponent(
                      player: trackerState.players[1],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: playerDivide),
          Expanded(
            flex: 3,
            child: PlayerComponent(
              player: trackerState.players[2],
            ),
          ),
        ],
      ),
    );
  }
}
