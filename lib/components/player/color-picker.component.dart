import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.model.dart';
import '../../states/tracker.state.dart';
import '../shared/button.component.dart';

class ColorPickerComponent extends StatelessWidget {
  const ColorPickerComponent({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return ButtonComponent(
      width: 40,
      height: 1000,
      onPressed: () {
        trackerState.changePlayerColor(player.number);
      },
      child: Container(
        decoration: BoxDecoration(
          color: player.color,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
