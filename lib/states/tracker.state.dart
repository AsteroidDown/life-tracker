import 'dart:math';
import 'package:flutter/material.dart';

import '../models/counter.model.dart';
import '../models/game-data.model.dart';
import '../models/player.model.dart';
import '../models/template.model.dart';

const int commanderPunchTime = 150;

enum Status { start, playing, end }

class TrackerState extends ChangeNotifier {
  Template? template;

  List<Player> players = [];

  Status status = Status.playing;

  int selectedPlayer = 0;
  int firstPlayer = -1;
  int monarch = -1;

  int commanderDamagePlayer = -1;
  bool gaveCommander = false;

  bool alternateLayout = false;

  bool resetting = false;

  List<Color> playerColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.orange,
    Colors.purple,
    Colors.lime,
    Colors.brown,
    Colors.grey,
  ];

  List<Color> playerDarkColors = [
    Colors.red.shade900,
    Colors.blue.shade900,
    Colors.green.shade900,
    Colors.yellow.shade900,
    Colors.pink.shade900,
    Colors.orange.shade900,
    Colors.purple.shade900,
    Colors.lime.shade900,
    Colors.brown.shade900,
    Colors.grey.shade900,
  ];

  void setTemplate(Template template) {
    this.template = template;

    if (template.gameData != null) {
      players = template.gameData!.players;
      monarch = template.gameData!.monarch!;
      alternateLayout = template.gameData!.alternateLayout!;
    } else {
      players = [];

      for (int i = 0; i < template.playerCount; i++) {
        addPlayer(i, template.startingLife);
      }

      for (int player = 0; player < template.playerCount; player++) {
        for (int opponent = 0; opponent < template.playerCount; opponent++) {
          if (player != opponent) {
            players[player].commanderTaken.add([opponent, 0, 0]);
          }
        }
      }
    }
  }

  GameData getGameData() {
    return GameData(template, players, monarch, alternateLayout);
  }

  void toggleLayout() {
    alternateLayout = !alternateLayout;
    notifyListeners();
  }

  Player getPlayer(int playerNumber) {
    return players[playerNumber];
  }

  void addPlayer(int playerNumber, int lifeTotal) {
    players.add(Player(
      playerNumber,
      lifeTotal,
      playerColors[playerNumber],
      playerDarkColors[playerNumber],
    ));
  }

  void updatePlayer(int number, PlayerProperties data) {
    var player = players[number];

    if (data.lifeTotal != null) {
      player.lifeTotal = data.lifeTotal!;
    }
    if (data.color != null) {
      player.color = data.color!;
    }
    if (data.colorDark != null) {
      player.colorDark = data.colorDark!;
    }
    if (data.active != null) {
      player.active = data.active!;
    }
    if (data.counters != null) {
      player.counters = data.counters!;
    }
    if (data.commanderTaken != null) {
      player.commanderTaken = data.commanderTaken!;
    }

    notifyListeners();
  }

  void changePlayerColor(int playerNumber) {
    Player player = players[playerNumber];

    int colorIndex = playerColors.indexWhere((color) => color == player.color);
    player.color = playerColors[(colorIndex + 1) % playerColors.length];
    player.colorDark =
        playerDarkColors[(colorIndex + 1) % playerDarkColors.length];

    notifyListeners();
  }

  List<Color> getActiveColors() {
    List<Color> colors = [];

    for (Player player in players) {
      colors.add(player.color!);
    }

    return colors;
  }

  void reset() async {
    monarch = -1;
    commanderDamagePlayer = -1;

    for (Player player in players) {
      List<List<int>> commanderTaken = [];

      for (int i = 0; i < player.commanderTaken.length; i++) {
        commanderTaken.add([player.commanderTaken[i][0], 0, 0]);
      }

      updatePlayer(
        player.number,
        PlayerProperties(
          counters: [],
          commanderTaken: commanderTaken,
          lifeTotal: template!.startingLife,
        ),
      );
    }

    resetting = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 50));
    resetting = false;
    notifyListeners();
  }

  bool getActiveState(int playerNumber) {
    if (status == Status.start) {
      return selectedPlayer == playerNumber;
    } else if (status == Status.playing) {
      return true;
    } else {
      return true;
    }
  }

  void chooseStartingPlayer() async {
    status = Status.start;
    selectedPlayer = -1;
    firstPlayer = -1;

    int rounds = Random().nextInt(players.length) +
        (players.length * 5 < 20 ? 16 : players.length * 5);

    for (int i = 0; i < rounds && status == Status.start; i++) {
      int duration = (25 - (5 * (players.length - 2))) * i;
      if (duration > 250) duration = 250;

      selectedPlayer = (i % players.length);
      await Future.delayed(Duration(milliseconds: duration));
      notifyListeners();
    }

    int winner = selectedPlayer;
    // for (int i = 0; i < 10 && status == Status.start; i++) {
    //   if (i % 2 == 0) {
    //     selectedPlayer = -1;
    //   } else {
    //     selectedPlayer = winner;
    //   }

    //   await Future.delayed(Duration(milliseconds: 150));
    //   notifyListeners();
    // }

    if (status == Status.start) firstPlayer = winner;
    notifyListeners();
  }

  void exitChooseStartingPlayer() {
    status = Status.playing;
    selectedPlayer = -1;
    firstPlayer = -1;
    notifyListeners();
  }

  void togglePartners(int playerNumber) {
    players[playerNumber].partners = !players[playerNumber].partners;
    notifyListeners();
  }

  void toggleCommanderDamage(int player, bool commander) {
    if (commander) {
      commanderDamagePlayer = player;
    } else {
      commanderDamagePlayer = -1;
    }
    notifyListeners();
  }

  bool givingCommander(int player) {
    return commanderDamagePlayer >= 0 ? player != commanderDamagePlayer : false;
  }

  int getCommanderGiven(int player, [bool? partner]) {
    if (commanderDamagePlayer == -1 || commanderDamagePlayer == player) {
      return 0;
    }
    return players[commanderDamagePlayer]
        .commanderTaken
        .firstWhere((damage) => damage[0] == player)[partner == true ? 2 : 1];
  }

  void subtractCommander(int playerNumber, [bool? partner]) async {
    var damage = players[commanderDamagePlayer]
        .commanderTaken
        .firstWhere((damage) => damage[0] == playerNumber);

    if (partner == true ? damage[2] > 0 : damage[1] > 0) {
      damage[partner == true ? 2 : 1] -= 1;
      if (template!.commander) players[commanderDamagePlayer].lifeTotal += 1;

      gaveCommander = true;
      notifyListeners();

      await Future.delayed(Duration(milliseconds: commanderPunchTime));
      gaveCommander = false;
      notifyListeners();
    }
  }

  void addCommander(int playerNumber, [bool? partner]) async {
    var damage = players[commanderDamagePlayer]
        .commanderTaken
        .firstWhere((damage) => damage[0] == playerNumber);

    damage[partner == true ? 2 : 1] += 1;
    if (template!.commander) players[commanderDamagePlayer].lifeTotal -= 1;

    gaveCommander = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: commanderPunchTime));
    gaveCommander = false;
    notifyListeners();
  }

  void exitCommander() {
    commanderDamagePlayer = -1;
    notifyListeners();
  }

  List<Counter> getCounters(int playerNumber) {
    return players[playerNumber].counters;
  }

  Counter getCounter(int playerNumber, String label) {
    return players[playerNumber]
        .counters
        .firstWhere((counter) => counter.label == label);
  }

  bool hasCounter(int playerNumber, String label) {
    return players[playerNumber]
        .counters
        .any((counter) => counter.label == label);
  }

  List<Counter> getActiveCounters(int playerNumber) {
    List<Counter> activeCounters = [];

    for (Counter counter in players[playerNumber].counters) {
      activeCounters.add(counter);
    }

    return activeCounters;
  }

  void addCounter(int playerNumber, String label) {
    players[playerNumber].counters.add(Counter(label));
    notifyListeners();
  }

  void removeCounter(int playerNumber, String label) {
    int index = players[playerNumber]
        .counters
        .indexWhere((counter) => counter.label == label);
    players[playerNumber].counters.removeAt(index);

    if (players[playerNumber].counters.isEmpty) {
      toggleEditCounters(playerNumber);
    } else {
      notifyListeners();
    }
  }

  void toggleEditCounters(int playerNumber) {
    players[playerNumber].editingCounters =
        !players[playerNumber].editingCounters;
    notifyListeners();
  }

  void addToCounter(int playerNumber, String label) {
    int increment = label == 'Tax' ? 2 : 1;
    players[playerNumber]
        .counters
        .firstWhere((counter) => counter.label == label)
        .count += increment;
    notifyListeners();
  }

  void removeFromCounter(int playerNumber, String label) {
    int increment = label == 'Tax' ? 2 : 1;

    players[playerNumber]
        .counters
        .firstWhere((counter) => counter.label == label)
        .count -= increment;
    notifyListeners();
  }

  void setMonarch(int playerNumber) {
    monarch = playerNumber;
    notifyListeners();
  }
}
