import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/template.model.dart';
import '../../states/tracker.state.dart';
import '../player/player.component.dart';

class OnePlayer extends StatelessWidget {
  const OnePlayer({Key? key, required this.template}) : super(key: key);

  final Template template;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    if (trackerState.template == null) {
      trackerState.setTemplate(template);
    }

    if (trackerState.alternateLayout) {
      return OnePlayerLayoutTwo();
    }

    return OnePlayerLayoutOne();
  }
}

class OnePlayerLayoutOne extends StatelessWidget {
  const OnePlayerLayoutOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      color: Colors.black,
      child: Expanded(
        child: PlayerComponent(
          player: trackerState.players[0],
        ),
      ),
    );
  }
}

class OnePlayerLayoutTwo extends StatelessWidget {
  const OnePlayerLayoutTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      color: Colors.black,
      child: Expanded(
        child: RotatedBox(
          quarterTurns: 1,
          child: PlayerComponent(
            player: trackerState.players[0],
          ),
        ),
      ),
    );
  }
}
