import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_app/components/shared/radial.component.dart';

import '../../models/game-data.model.dart';
import '../../states/tracker.state.dart';
import 'tracker-icon-button.component.dart';
import 'tracker-setting.component.dart';

const double radius = 76;
const double size = 48;

class DefaultSettingsPage extends StatelessWidget {
  const DefaultSettingsPage({
    super.key,
    required this.curve,
    required this.duration,
    required this.pageController,
    required this.toggle,
  });

  final Curve curve;
  final Duration duration;
  final PageController pageController;
  final VoidCallback toggle;

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();

  //   return directory.path;
  // }

  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   return File('$path/game-data.txt');
  // }

  // Future<File> writeGameData(GameData gameData) async {
  //   final file = await _localFile;

  //   String json = jsonEncode(gameData);
  //   List<int> bytes = utf8.encode(json);

  //   return file.writeAsBytes(bytes);
  // }

  @override
  Widget build(BuildContext context) {
    var trackerState = context.watch<TrackerState>();

    List<String> names = [
      'Home',
      'First',
      'Layout',
      'Dice',
      'Reset',
    ];
    List<IconData> icons = [
      Icons.home_rounded,
      Icons.repeat_one_rounded,
      Icons.dashboard_rounded,
      Icons.casino_rounded,
      Icons.refresh_rounded,
    ];
    List<void Function()> actions = [
      () => {
            // writeGameData(trackerState.getGameData()),
            Navigator.of(context).popUntil((route) => route.isFirst),
          },
      () => {
            toggle(),
            trackerState.chooseStartingPlayer(),
          },
      () async => {
            trackerState.toggleLayout(),
            toggle(),
          },
      () => {
            pageController.nextPage(
              curve: curve,
              duration: duration,
            )
          },
      () => {
            pageController.previousPage(
              curve: curve,
              duration: duration,
            )
          },
    ];

    return Stack(
      children: [
        for (int index = 0; index < names.length; index++)
          RadialComponent(
            radius: radius,
            angle: ((2 * pi) / names.length) * index - 1.56,
            child: Transform.rotate(
              angle: (pi * 0.5) + (2 * (pi / names.length) * index) - 1.58,
              child: TrackerIconButton(
                label: names[index],
                size: size,
                duration: duration,
                color: trackerState.playerColors[index],
                icon: Icon(icons[index]),
                onPressed: actions[index],
              ),
            ),
          ),
        Center(
          child: IconButton(
            icon: Icon(Icons.close_rounded),
            color: Colors.white,
            iconSize: minWidth,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              toggle();
            },
          ),
        ),
      ],
    );
  }
}
