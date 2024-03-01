import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_app/components/player/life-total.component.dart';
import '../../models/player.model.dart';
import '../../states/tracker.state.dart';

const int fadeTime = 1000;

class PlayerLifeComponent extends StatefulWidget {
  const PlayerLifeComponent({
    super.key,
    required this.playerState,
  });

  final Player playerState;

  @override
  State<PlayerLifeComponent> createState() => _PlayerLifeComponentState();
}

class _PlayerLifeComponentState extends State<PlayerLifeComponent> {
  @override
  void initState() {
    player = Player(
      widget.playerState.number,
      widget.playerState.lifeTotal,
      widget.playerState.color,
      widget.playerState.colorDark,
    );

    super.initState();
  }

  late Player player;

  Status gameState = Status.start;

  bool active = false;

  int index = 0;
  Color startColor = Colors.red;
  Color endColor = Colors.blue;

  Duration duration = Duration(milliseconds: 300);

  Color getPlayerColor() {
    if (active) {
      return player.color!;
    } else {
      return player.colorDark!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    player = trackerState.getPlayer(player.number);
    active = trackerState.getActiveState(player.number);

    gameState = trackerState.status;

    List<Color> colors = trackerState.getActiveColors();

    Color playerColor = getPlayerColor();

    subtractLife() {
      trackerState.updatePlayer(
        player.number,
        PlayerProperties(lifeTotal: player.lifeTotal - 1),
      );
    }

    addLife() {
      trackerState.updatePlayer(
        player.number,
        PlayerProperties(lifeTotal: player.lifeTotal + 1),
      );
    }

    return AnimatedContainer(
      duration: Duration(
        milliseconds: trackerState.firstPlayer == player.number
            ? 1000
            : trackerState.status == Status.start
                ? 0
                : fadeTime,
      ),
      onEnd: () async => {
        if (trackerState.firstPlayer == player.number)
          {
            setState(() {
              index = index + 1;
              startColor = colors[index % colors.length];
              endColor = colors[(index + 1) % colors.length];
            }),
          },
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: trackerState.firstPlayer == player.number
              ? [
                  startColor,
                  endColor,
                ]
              : [
                  playerColor,
                  playerColor.withAlpha(180),
                ],
        ),
      ),
      child: Stack(
        children: [
          LifeTotalComponent(
            player: player,
            onLifeLost: () => subtractLife(),
            onLifeGain: () => addLife(),
          ),
          AnimatedOpacity(
            duration: duration,
            opacity: trackerState.monarch != -1 ? 1 : 0,
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  size: 32,
                  color: trackerState.monarch == player.number
                      ? Colors.grey.shade900
                      : Colors.grey.shade300.withAlpha(144),
                  FontAwesomeIcons.crown,
                ),
                onPressed: () => {trackerState.setMonarch(player.number)},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
