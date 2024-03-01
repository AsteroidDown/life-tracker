import 'game-data.model.dart';

class Template {
  int playerCount;
  int startingLife;

  bool commander;

  GameData? gameData;

  Template(
    this.playerCount,
    this.startingLife,
    this.commander, [
    this.gameData,
  ]);

  Template.fromJson(Map<String, dynamic> json)
      : playerCount = json['playerCount'] as int,
        startingLife = json['startingLife'] as int,
        commander = json['commander'] as bool;

  Map<String, dynamic> toJson() {
    return {
      'playerCount': playerCount,
      'startingLife': startingLife,
      'commander': commander,
    };
  }

  @override
  String toString() {
    String str = '\nPlayer Count $playerCount';
    str += '\nStarting Life: $startingLife';
    str += '\nCommander: $commander';
    str += '\nGame Data: $gameData';

    return str;
  }
}
