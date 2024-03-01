import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../models/counter.model.dart';
import '../../models/player.model.dart';
import '../../states/tracker.state.dart';
import 'commander-given.component.dart';
import 'commander.component.dart';
import 'counters-reference.component.dart';
import 'player-life.component.dart';
import 'player-details.component.dart';

const int fadeTime = 1000;
const int commanderFadeTime = 300;

class PlayerComponent extends StatefulWidget {
  const PlayerComponent({super.key, required this.player});

  final Player player;

  @override
  State<PlayerComponent> createState() => _PlayerComponentState();
}

class _PlayerComponentState extends State<PlayerComponent> {
  int currentHorizontalPage = 1000;
  int currentVerticalPage = 1000;

  bool givingCommander = false;

  List<Counter> activeCounters = [];

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();
    var player = widget.player;

    var horizontalPageController = PageController(
      initialPage: currentHorizontalPage,
    );

    var verticalPageController = PageController(
      initialPage: currentHorizontalPage,
    );

    givingCommander = trackerState.givingCommander(player.number);
    activeCounters = trackerState.getActiveCounters(player.number);

    goHomeHorizontal() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (horizontalPageController.hasClients &&
            currentHorizontalPage % 2 != 0) {
          currentHorizontalPage -= 1;
          horizontalPageController.animateToPage(
            currentHorizontalPage,
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
          );
        }
      });
    }

    goHomeVertical() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (verticalPageController.hasClients && currentVerticalPage % 2 != 0) {
          currentVerticalPage -= 1;
          verticalPageController.animateToPage(
            currentVerticalPage,
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
          );
        }
      });
    }

    if (trackerState.resetting || trackerState.status == Status.start) {
      goHomeVertical();
      goHomeHorizontal();
    }

    if (trackerState.commanderDamagePlayer == -1 ||
        (trackerState.commanderDamagePlayer >= 0 &&
            trackerState.commanderDamagePlayer != player.number)) {
      goHomeHorizontal();
    }

    final horizontalChildren = <Widget>[
      Column(
        children: [
          Expanded(
            child: PlayerLifeComponent(
              playerState: player,
            ),
          ),
          CountersReferenceComponent(
            activeCounters: activeCounters,
            player: player,
          ),
        ],
      ),
      CommanderComponent(player: player),
    ];

    final verticalChildren = <Widget>[
      PageView.builder(
        controller: horizontalPageController,
        itemBuilder: (context, index) {
          return horizontalChildren[index % horizontalChildren.length];
        },
        onPageChanged: (page) => {
          currentHorizontalPage = page,
          trackerState.toggleCommanderDamage(
              player.number, page % horizontalChildren.length == 1)
        },
        physics: trackerState.status == Status.start ||
                (trackerState.commanderDamagePlayer >= 0 &&
                    trackerState.commanderDamagePlayer != player.number)
            ? NeverScrollableScrollPhysics()
            : null,
      ),
      PlayerDetailsComponent(
        player: player,
      ),
    ];

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: givingCommander ? 0 : 1,
            duration: Duration(milliseconds: commanderFadeTime),
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: verticalPageController,
              itemBuilder: (context, index) {
                return verticalChildren[index % verticalChildren.length];
              },
              onPageChanged: (page) => {
                currentVerticalPage = page,
              },
              physics: trackerState.commanderDamagePlayer >= 0 ||
                      trackerState.status == Status.start
                  ? NeverScrollableScrollPhysics()
                  : null,
            ),
          ),
          IgnorePointer(
            ignoring: !givingCommander,
            child: AnimatedOpacity(
              opacity: givingCommander ? 1 : 0,
              duration: Duration(milliseconds: commanderFadeTime),
              child: CommanderGivenComponent(player: player),
            ),
          ),
        ],
      ),
    );
  }
}
