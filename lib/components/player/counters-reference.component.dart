import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/components/shared/button.component.dart';

import '../../models/counter.model.dart';
import '../../models/player.model.dart';
import '../../states/tracker.state.dart';

class CountersReferenceComponent extends StatelessWidget {
  const CountersReferenceComponent({
    super.key,
    required this.activeCounters,
    required this.player,
  });

  final List<Counter> activeCounters;
  final Player player;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    return Container(
      alignment: Alignment.center,
      height: activeCounters.isNotEmpty ? 40 : 0,
      decoration: BoxDecoration(
        color: player.colorDark!.withAlpha(90),
      ),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          activeCounters.length,
          (int index) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
              decoration: BoxDecoration(
                border: index < activeCounters.length - 1
                    ? Border(
                        right: BorderSide(
                          color: Colors.grey.shade600,
                        ),
                      )
                    : null,
              ),
              child: ButtonComponent(
                shouldAnimate: false,
                onPressed: () => {
                  trackerState.addToCounter(
                    player.number,
                    activeCounters[index].label,
                  ),
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image(
                        image: AssetImage(
                            'assets/${activeCounters[index].label}.png'),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '${activeCounters[index].count}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey.shade300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
