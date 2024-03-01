import 'dart:convert';

import 'package:test_app/models/player.model.dart';
import 'package:test_app/models/template.model.dart';

class GameData {
  Template? template;

  List<Player> players = [];

  int? monarch;

  bool? alternateLayout;

  GameData(
    this.template,
    this.players,
    this.monarch,
    this.alternateLayout,
  );

  GameData.fromJson(Map<String, dynamic> json)
      : monarch = json['monarch'] as int?,
        template = Template.fromJson(json['template']),
        alternateLayout = json['alternateLayout'] as bool?,
        players = (jsonDecode(json['players']) as List?)
                ?.map((player) => Player.fromJson(player))
                .toList() ??
            [];

  Map<String, dynamic> toJson() {
    return {
      'monarch': monarch,
      'players': jsonEncode(players),
      'template': template!.toJson(),
      'alternateLayout': alternateLayout,
    };
  }

  @override
  String toString() {
    String str = '\nMonarch $monarch';
    str += '\nAlternate Layout: $alternateLayout';
    str += '\nTemplate: $template';
    str += '\nPlayers: $players';

    return str;
  }
}
