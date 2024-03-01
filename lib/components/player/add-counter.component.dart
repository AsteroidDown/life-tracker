import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/components/shared/button.component.dart';

import '../../models/player.model.dart';
import '../../states/tracker.state.dart';

const int fadeTime = 150;

class AddCounterComponent extends StatelessWidget {
  const AddCounterComponent({
    super.key,
    required this.player,
    required this.counterAdded,
  });

  final Player player;
  final ValueChanged<String> counterAdded;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    List<String> topRowCounters = [
      'Poison',
      'Storm',
      'Energy',
      'XP',
    ];

    List<String> bottomRowCounters = [
      'White',
      'Blue',
      'Black',
      'Red',
      'Green',
      'Colorless'
    ];

    return Container(
      constraints: BoxConstraints(
        maxWidth: 400,
        maxHeight: 1000,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                for (String type in topRowCounters)
                  CounterIconButton(
                    type: type,
                    counterAdded: counterAdded,
                    disabled: trackerState.hasCounter(player.number, type),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                for (String type in bottomRowCounters)
                  CounterIconButton(
                    type: type,
                    counterAdded: counterAdded,
                    disabled: trackerState.hasCounter(player.number, type),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CounterIconButton extends StatelessWidget {
  const CounterIconButton({
    super.key,
    required this.type,
    required this.disabled,
    required this.counterAdded,
  });

  final String type;
  final bool disabled;
  final ValueChanged<String> counterAdded;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ButtonComponent(
        borderRadius: 99,
        disabled: disabled,
        margin: EdgeInsets.all(2),
        onPressed: () => {
          counterAdded(type),
        },
        child: Expanded(
          child: Image(
            image: AssetImage('assets/$type.png'),
          ),
        ),
      ),
    );
  }
}
