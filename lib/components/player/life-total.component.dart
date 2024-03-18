import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.model.dart';
import '../../states/tracker.state.dart';
import 'player.component.dart';

const double minPadding = 32;
const double maxPadding = 100;

class LifeTotalComponent extends StatefulWidget {
  const LifeTotalComponent({
    super.key,
    required this.player,
    required this.onLifeLost,
    required this.onLifeGain,
    this.commander = false,
    this.partner = false,
    this.color,
  });

  final Player player;
  final VoidCallback onLifeLost;
  final VoidCallback onLifeGain;

  final bool commander;
  final bool partner;
  final Color? color;

  @override
  State<LifeTotalComponent> createState() => _LifeTotalComponentState();
}

class _LifeTotalComponentState extends State<LifeTotalComponent> {
  @override
  void initState() {
    color = widget.color;
    commander = widget.commander;

    if (commander) {
      currentLife = 0;
      prevLife = 0;
    } else {
      currentLife = widget.player.lifeTotal;
      prevLife = widget.player.lifeTotal;
    }

    super.initState();
  }

  Color? color;
  bool commander = false;
  int commanderGiven = 0;

  int lifeTime = 0;

  int currentLife = 20;
  int prevLife = 20;

  lifeChangeFade([int? life]) async {
    lifeTime = fadeTime;
    currentLife =
        life ?? (commander ? commanderGiven : widget.player.lifeTotal);
    var diff = currentLife - prevLife;

    while (lifeTime > 0 && diff == currentLife - prevLife) {
      if (mounted) {
        setState(() {
          lifeTime -= 10;
        });
        await Future.delayed(Duration(milliseconds: 10));
      }
    }

    if (lifeTime <= 0 && diff == currentLife - prevLife && mounted) {
      await Future.delayed(Duration(milliseconds: fadeTime));

      if (diff == currentLife - prevLife && mounted) {
        setState(() {
          currentLife = commander ? commanderGiven : widget.player.lifeTotal;
          prevLife = commander ? commanderGiven : widget.player.lifeTotal;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();
    Player player = trackerState.getPlayer(widget.player.number);

    commanderGiven =
        trackerState.getCommanderGiven(player.number, widget.partner);

    if (trackerState.resetting) {
      currentLife = commander ? 0 : player.lifeTotal;
      prevLife = commander ? 0 : player.lifeTotal;
    }

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: lifeTime > 0 ? 1 : 0.5,
                      duration:
                          Duration(milliseconds: lifeTime > 0 ? 0 : fadeTime),
                      child: IconButton(
                        icon: Icon(Icons.remove_rounded),
                        color: color ?? Colors.grey.shade900,
                        style: IconButton.styleFrom(
                          iconSize: 40,
                          shape: LinearBorder(),
                          padding: EdgeInsets.only(
                            right: commander &&
                                    player.partners &&
                                    trackerState.commanderDamagePlayer !=
                                        player.number
                                ? minPadding
                                : maxPadding,
                          ),
                        ),
                        onPressed: commander
                            ? (commanderGiven > 0 &&
                                    trackerState.status != Status.start
                                ? () {
                                    widget.onLifeLost();
                                    lifeChangeFade(currentLife - 1);
                                  }
                                : null)
                            : trackerState.status != Status.start
                                ? () {
                                    widget.onLifeLost();
                                    lifeChangeFade();
                                  }
                                : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: lifeTime > 0 ? 1 : 0.5,
                      duration:
                          Duration(milliseconds: lifeTime > 0 ? 0 : fadeTime),
                      child: IconButton(
                        icon: Icon(Icons.add_rounded),
                        color: color ?? Colors.grey.shade900,
                        style: IconButton.styleFrom(
                          iconSize: 40,
                          shape: LinearBorder(),
                          padding: EdgeInsets.only(
                            left: commander &&
                                    player.partners &&
                                    trackerState.commanderDamagePlayer !=
                                        player.number
                                ? minPadding
                                : maxPadding,
                          ),
                        ),
                        onPressed: trackerState.status != Status.start
                            ? () {
                                widget.onLifeGain();
                                if (commander) {
                                  lifeChangeFade(currentLife + 1);
                                } else {
                                  lifeChangeFade();
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Center(
          child: IgnorePointer(
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: trackerState.firstPlayer == player.number
                    ? Colors.grey.shade100
                    : color ?? Colors.grey.shade900,
                fontSize: commander &&
                        player.partners &&
                        trackerState.players.length > 4
                    ? 64
                    : 112,
              ),
              child: Text(
                '${commander ? commanderGiven : player.lifeTotal}',
              ),
            ),
          ),
        ),
        Center(
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: lifeTime > 0 ? 1 : 0,
              duration: Duration(milliseconds: lifeTime > 0 ? 0 : fadeTime),
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentLife != prevLife
                          ? (currentLife > prevLife
                              ? Icons.add_rounded
                              : Icons.remove_rounded)
                          : null,
                      color: color ?? Colors.grey.shade900,
                    ),
                    Text(
                      '${currentLife != prevLife ? (currentLife - prevLife).abs() : ""}',
                      style: TextStyle(
                        fontSize: 28,
                        color: color ?? Colors.grey.shade900,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
