import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/counter.model.dart';
import '../../states/tracker.state.dart';

const int fadeTime = 150;

const double baseWidth = 80;
const double maxWidth = 96;

class CounterComponent extends StatefulWidget {
  const CounterComponent({
    super.key,
    required this.counter,
    required this.playerNumber,
    this.adding,
    this.onAdd,
    this.onSubtract,
  });

  final Counter counter;
  final int playerNumber;

  final bool? adding;

  final VoidCallback? onAdd;
  final VoidCallback? onSubtract;

  @override
  State<CounterComponent> createState() => _CounterComponentState();
}

class _CounterComponentState extends State<CounterComponent> {
  bool editing = false;
  bool removing = false;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    editing = trackerState.players[widget.playerNumber].editingCounters;

    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(),
      duration: Duration(milliseconds: fadeTime),
      width: removing || widget.adding == true ? 0 : baseWidth,
      child: OverflowBox(
        maxWidth: baseWidth,
        alignment: Alignment.centerLeft,
        child: Container(
          width: baseWidth,
          margin: EdgeInsets.only(left: 8),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.counter.count}',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.grey.shade300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: Image(
                        image: AssetImage('assets/${widget.counter.label}.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (editing != true)
                      Expanded(
                        child: IconButton(
                          color: Colors.grey.shade300,
                          icon: Icon(Icons.add_rounded),
                          style: IconButton.styleFrom(
                            iconSize: 32,
                            shape: LinearBorder(),
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 12),
                          ),
                          onPressed: widget.onAdd != null
                              ? () => {
                                    widget.onAdd!(),
                                  }
                              : null,
                        ),
                      ),
                    Expanded(
                      child: IconButton(
                        color: Colors.grey.shade300,
                        icon: Icon(editing == true
                            ? widget.counter.label != 'Tax'
                                ? Icons.delete_forever_rounded
                                : null
                            : Icons.remove_rounded),
                        style: IconButton.styleFrom(
                          iconSize: 32,
                          shape: LinearBorder(),
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 12),
                        ),
                        onPressed: editing == true
                            ? () async => {
                                  if (widget.counter.label != 'Tax')
                                    {
                                      setState(() {
                                        removing = true;
                                      }),
                                      await Future.delayed(
                                          Duration(milliseconds: fadeTime)),
                                      trackerState.removeCounter(
                                        widget.playerNumber,
                                        widget.counter.label,
                                      ),
                                    }
                                }
                            : widget.onSubtract != null
                                ? () => {
                                      widget.onSubtract!(),
                                    }
                                : null,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
