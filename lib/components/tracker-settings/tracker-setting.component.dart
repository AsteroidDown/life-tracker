import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/tracker.state.dart';
import 'are-you-sure-page.component.dart';
import 'default-settings-page.component.dart';
import 'dice-page.component.dart';
import 'roll-result-page.component.dart';

const int animationDuration = 150;

const double minWidth = 44;
const double maxWidth = 240;
const double minHeight = minWidth;
const double maxHeight = maxWidth;

class TrackerSettings extends StatefulWidget {
  const TrackerSettings({Key? key}) : super(key: key);

  @override
  State<TrackerSettings> createState() => _TrackerSettingsState();
}

class _TrackerSettingsState extends State<TrackerSettings> {
  bool open = false;

  double height = minHeight;
  double width = minWidth;

  Curve curve = Curves.easeOut;
  Duration duration = Duration(milliseconds: animationDuration);

  int rollResult = 0;

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    var pageController = PageController(initialPage: 1);

    toggle() {
      setState(() {
        open = !open;
        height = open ? maxHeight : minHeight;
        width = open ? maxWidth : minWidth;
      });

      if (open) {
        pageController.animateToPage(
          1,
          curve: curve,
          duration: Duration(milliseconds: 1),
        );
      }
    }

    return Expanded(
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: !open,
            child: GestureDetector(
              onTap: () => {
                toggle(),
                pageController.animateToPage(0,
                    duration: duration, curve: curve),
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: open ? 4 : 0,
                  sigmaY: open ? 4 : 0,
                ),
                child: AnimatedContainer(
                  duration: duration,
                  color: Colors.grey.shade900.withAlpha(open ? 60 : 0),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              curve: curve,
              duration: duration,
              width: open ? maxWidth : minWidth,
              height: open ? maxHeight : minHeight,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(48),
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: open ? 16 : 0),
                ],
                border: Border.all(
                  width: 3,
                  color: Colors.grey.shade300,
                ),
              ),
              child: OverflowBox(
                // minWidth: 400,
                // minHeight: 400,
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    AreYouSurePage(
                      curve: curve,
                      duration: duration,
                      pageController: pageController,
                      toggle: () => {
                        toggle(),
                        trackerState.reset(),
                      },
                    ),
                    DefaultSettingsPage(
                      curve: curve,
                      duration: duration,
                      pageController: pageController,
                      toggle: () => {
                        toggle(),
                      },
                    ),
                    DicePage(
                      rollDice: (diceType) => {
                        setState(() {
                          rollResult = Random().nextInt(diceType) + 1;
                        }),
                        pageController.nextPage(
                          duration: duration,
                          curve: Curves.ease,
                        ),
                      },
                      goBack: () => {
                        pageController.previousPage(
                          duration: duration,
                          curve: curve,
                        )
                      },
                    ),
                    RollResultPage(
                      duration: duration,
                      rollResult: rollResult,
                      pageController: pageController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: IgnorePointer(
              ignoring: open,
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: open ? 0 : 1,
                    duration: duration,
                    child: IconButton(
                      icon: Icon(Icons.circle_outlined),
                      color: Colors.white,
                      iconSize: minWidth,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        toggle();
                      },
                    ),
                  ),
                  IgnorePointer(
                    ignoring: trackerState.status == Status.start
                        ? false
                        : trackerState.commanderDamagePlayer == -1,
                    child: AnimatedOpacity(
                      duration: duration,
                      opacity: trackerState.commanderDamagePlayer > -1 ||
                              trackerState.status == Status.start
                          ? 1
                          : 0,
                      child: IconButton(
                        icon: Icon(Icons.close_rounded),
                        color: Colors.white,
                        iconSize: minWidth,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          if (trackerState.status == Status.start) {
                            trackerState.exitChooseStartingPlayer();
                          } else {
                            trackerState.exitCommander();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
