import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/components/shared/button.component.dart';
import 'package:test_app/models/template.model.dart';

import '../models/game-data.model.dart';
import 'tracker.page.dart';

const double boxSize = 80;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => readGameData());
  }

  GameData? gameData;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/game-data.txt');
  }

  Future<GameData?> readGameData() async {
    try {
      final file = await _localFile;

      final data = await file.readAsBytes();

      final jsonData = utf8.decode(data);

      var decoded = json.decode(jsonData);

      return GameData.fromJson(decoded);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // readGameData().then((data) => setState(() {
    //       gameData = data;
    //       print(gameData);
    //     }));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade700,
            Colors.red.shade900,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(),
            SizedBox(height: 44),
            ButtonComponent(
              shouldAnimate: false,
              onPressed: () {
                Navigator.pushNamed(context, '/template');
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 4,
                    color: Colors.grey.shade900.withAlpha(80),
                  ),
                  color: Colors.grey.shade900.withAlpha(100),
                ),
                child: Text(
                  'New Game',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.grey.shade300,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            ButtonComponent(
              shouldAnimate: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackerPage(
                      template: Template(4, 40, true),
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 4,
                    color: Colors.grey.shade900.withAlpha(80),
                  ),
                  color: Colors.grey.shade900.withAlpha(100),
                ),
                child: Text(
                  'Quick Start',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.grey.shade300,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            if (gameData != null)
              ButtonComponent(
                shouldAnimate: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackerPage(
                        template: Template(
                          gameData!.template!.playerCount,
                          gameData!.template!.startingLife,
                          gameData!.template!.commander,
                          gameData,
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 4,
                      color: Colors.grey.shade900.withAlpha(80),
                    ),
                    color: Colors.grey.shade900.withAlpha(100),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.grey.shade300,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184,
      padding: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.red,
                    child: SizedBox(
                      width: boxSize,
                      height: boxSize,
                    ),
                  ),
                  Card(
                    color: Colors.blue,
                    child: SizedBox(
                      width: boxSize,
                      height: boxSize,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.yellow,
                    child: SizedBox(
                      width: boxSize,
                      height: boxSize,
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: SizedBox(
                      width: boxSize,
                      height: boxSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 176,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Icon(
                  size: 36,
                  color: Colors.white,
                  Icons.circle_outlined,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
