import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/counter.model.dart';
import '../../models/player.model.dart';
import '../../states/tracker.state.dart';
import 'add-counter.component.dart';
import 'color-picker.component.dart';
import 'counter.component.dart';

const double maxHeight = 360;

class PlayerCountersComponent extends StatefulWidget {
  const PlayerCountersComponent({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  State<PlayerCountersComponent> createState() =>
      _PlayerCountersComponentState();
}

class _PlayerCountersComponentState extends State<PlayerCountersComponent> {
  @override
  void initState() {
    super.initState();

    player = widget.player;
  }

  late Player player;

  int addedCounterIndex = -1;

  addCounter(int index) async {
    setState(() {
      addedCounterIndex = index;
    });

    await Future.delayed(Duration(milliseconds: 10));

    setState(() {
      addedCounterIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    player = trackerState.getPlayer(player.number);

    List<Counter> counters = trackerState.getCounters(player.number);

    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: ColorPickerComponent(player: player),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Counters(
            player: player,
            counters: counters,
            trackerState: trackerState,
            addedCounterIndex: addedCounterIndex,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: EditCountersButtons(
            player: player,
            counters: counters,
            trackerState: trackerState,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: AddCounterComponent(
            player: player,
            counterAdded: (type) => {
              addCounter(counters.length),
              trackerState.addCounter(player.number, type),
            },
          ),
        ),
      ],
    );
  }
}

class Counters extends StatelessWidget {
  const Counters({
    super.key,
    required this.counters,
    required this.player,
    required this.addedCounterIndex,
    required this.trackerState,
  });

  final List<Counter> counters;
  final Player player;
  final int addedCounterIndex;
  final TrackerState trackerState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int index = 0; index < counters.length; index++)
          CounterComponent(
            counter: counters[index],
            playerNumber: player.number,
            adding: addedCounterIndex == index,
            onAdd: () => {
              trackerState.addToCounter(player.number, counters[index].label),
            },
            onSubtract: counters[index].count > 0
                ? () => {
                      trackerState.removeFromCounter(
                        player.number,
                        counters[index].label,
                      )
                    }
                : null,
          ),
      ],
    );
  }
}

class EditCountersButtons extends StatelessWidget {
  const EditCountersButtons({
    super.key,
    required this.counters,
    required this.player,
    required this.trackerState,
  });

  final List<Counter> counters;
  final Player player;
  final TrackerState trackerState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: SizedBox(
        width: 60,
        height: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (player.counters.isNotEmpty)
              IconButton(
                icon: Icon(
                  size: 32,
                  player.editingCounters
                      ? Icons.close_rounded
                      : Icons.edit_rounded,
                ),
                color: Colors.grey.shade50,
                onPressed: () => {
                  trackerState.toggleEditCounters(player.number),
                },
              ),
            if (player.counters.isNotEmpty) SizedBox(height: 12),
            if (trackerState.monarch == -1)
              IconButton(
                icon: Icon(
                  size: 32,
                  FontAwesomeIcons.crown,
                ),
                color: Colors.grey.shade50,
                onPressed: () => {
                  trackerState.setMonarch(player.number),
                },
              ),
          ],
        ),
      ),
    );
  }
}
