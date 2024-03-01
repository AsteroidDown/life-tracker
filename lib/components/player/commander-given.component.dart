import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.model.dart';
import '../../states/tracker.state.dart';
import 'life-total.component.dart';

class CommanderGivenComponent extends StatelessWidget {
  const CommanderGivenComponent({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      color: player.colorDark,
      child: Stack(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: LifeTotalComponent(
                    player: player,
                    commander: true,
                    color: Colors.grey.shade300,
                    onLifeLost: () => {
                      trackerState.subtractCommander(player.number),
                    },
                    onLifeGain: () => {
                      trackerState.addCommander(player.number),
                    },
                  ),
                ),
                if (player.partners)
                  Expanded(
                    flex: 1,
                    child: Transform.translate(
                      offset: Offset(-1.0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: player.color!,
                            ),
                          ),
                        ),
                        child: Expanded(
                          child: LifeTotalComponent(
                            player: player,
                            partner: true,
                            commander: true,
                            color: Colors.grey.shade300,
                            onLifeLost: () => {
                              trackerState.subtractCommander(
                                  player.number, true),
                            },
                            onLifeGain: () => {
                              trackerState.addCommander(player.number, true),
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(top: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: player.colorDark,
                  border: Border(
                    top: BorderSide(
                      width: 3,
                      color: player.color!,
                    ),
                    left: BorderSide(
                      width: 3,
                      color: player.color!,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                  ),
                ),
                child: IconButton(
                  iconSize: 32,
                  color: Colors.grey.shade50,
                  icon: Icon(
                    player.partners
                        ? Icons.group_outlined
                        : Icons.person_outline_rounded,
                  ),
                  onPressed: () => {
                    trackerState.togglePartners(player.number),
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
