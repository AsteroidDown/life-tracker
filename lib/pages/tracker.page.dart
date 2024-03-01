import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/tracker-settings/tracker-setting.component.dart';
import '../components/layouts/layouts.dart';
import '../models/template.model.dart';
import '../states/tracker.state.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({Key? key, required this.template}) : super(key: key);

  final Template template;

  @override
  Widget build(BuildContext context) {
    switch (template.playerCount) {
      case 1:
        return PopScope(
          canPop: false,
          child: ChangeNotifierProvider(
            create: (context) => TrackerState(),
            builder: (context, child) => Center(
              child: Stack(
                children: [
                  OnePlayer(template: template),
                  TrackerSettings(),
                ],
              ),
            ),
          ),
        );

      case 3:
        return PopScope(
          canPop: false,
          child: ChangeNotifierProvider(
            create: (context) => TrackerState(),
            builder: (context, child) => Center(
              child: Stack(
                children: [
                  ThreePlayers(template: template),
                  TrackerSettings(),
                ],
              ),
            ),
          ),
        );

      case 4:
        return PopScope(
          canPop: false,
          child: ChangeNotifierProvider(
            create: (context) => TrackerState(),
            builder: (context, child) => Center(
              child: Stack(
                children: [
                  FourPlayers(template: template),
                  TrackerSettings(),
                ],
              ),
            ),
          ),
        );

      case 5:
        return PopScope(
          canPop: false,
          child: ChangeNotifierProvider(
            create: (context) => TrackerState(),
            builder: (context, child) => Center(
              child: Stack(
                children: [
                  FivePlayers(template: template),
                  TrackerSettings(),
                ],
              ),
            ),
          ),
        );

      case 6:
        return PopScope(
          canPop: false,
          child: ChangeNotifierProvider(
            create: (context) => TrackerState(),
            builder: (context, child) => Center(
              child: Stack(
                children: [
                  SixPlayers(template: template),
                  TrackerSettings(),
                ],
              ),
            ),
          ),
        );

      default:
        return PopScope(
          canPop: false,
          child: ChangeNotifierProvider(
            create: (context) => TrackerState(),
            builder: (context, child) => Center(
              child: Stack(
                children: [
                  TwoPlayers(template: template),
                  TrackerSettings(),
                ],
              ),
            ),
          ),
        );
    }
  }
}
