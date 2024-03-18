import 'dart:convert';
import 'dart:ui';

import 'counter.model.dart';

class Player {
  int number;
  int lifeTotal;
  Color? color;
  Color? colorDark;

  bool partners = false;

  bool active = false;
  bool editingCounters = false;

  List<Counter> counters = [
    // Counter('Tax', 0),
  ];
  List<List<int>> commanderTaken = [];

  Player(
    this.number,
    this.lifeTotal, [
    this.color,
    this.colorDark,
    this.active = true,
  ]);

  Player.fromJson(Map<String, dynamic> json)
      : number = json['number'] as int,
        partners = json['partners'] as bool,
        lifeTotal = json['lifeTotal'] as int,
        color = Color(int.parse('0x${json['color']}')),
        colorDark = Color(int.parse('0x${json['colorDark']}')),
        commanderTaken = (jsonDecode(json['commanderTaken']) as List)
            .map((damageList) => List<int>.from(damageList))
            .toList(),
        counters = (jsonDecode(json['counters']) as List)
            .map((counter) => Counter.fromJson(counter))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'partners': partners,
      'lifeTotal': lifeTotal,
      'counters': jsonEncode(counters),
      'color': color!.value.toRadixString(16),
      'colorDark': colorDark!.value.toRadixString(16),
      'commanderTaken': jsonEncode(commanderTaken),
    };
  }

  @override
  String toString() {
    String str = '\n\nPlayer $number';
    str += '\nLife: $lifeTotal';
    str += '\nPartners: $partners';
    str += '\nColor: $color';
    str += '\nCommander Taken: $commanderTaken';
    str += '\nCounters: $counters';

    return '$str\n';
  }
}

class PlayerProperties {
  final int? lifeTotal;
  final Color? color;
  final Color? colorDark;

  final bool? active;
  final bool? partners;

  final List<Counter>? counters;
  final List<List<int>>? commanderTaken;

  PlayerProperties({
    this.lifeTotal,
    this.color,
    this.colorDark,
    this.active,
    this.partners,
    this.counters,
    this.commanderTaken,
  });
}
