import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.model.dart';
import '../../states/tracker.state.dart';
import 'player-counters.component.dart';

class PlayerDetailsComponent extends StatefulWidget {
  const PlayerDetailsComponent({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  State<PlayerDetailsComponent> createState() => _PlayerDetailsComponentState();
}

class _PlayerDetailsComponentState extends State<PlayerDetailsComponent> {
  @override
  void initState() {
    super.initState();

    player = widget.player;
  }

  late Player player;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    player = trackerState.getPlayer(player.number);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: PlayerCountersComponent(player: player),
      ),
    );
  }
}
