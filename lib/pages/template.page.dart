import 'package:flutter/material.dart';
import 'package:test_app/components/shared/button.component.dart';
import '../models/template.model.dart';
import 'tracker.page.dart';

const baseLife = 40;
const maxLife = 100;
const minLife = 10;

const basePlayers = 4;
const maxPlayers = 6;
const minPlayers = 2;

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key, this.templateState});

  final Template? templateState;

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  void initState() {
    super.initState();

    template = Template(basePlayers, baseLife, true);
  }

  late Template? template;

  setTemplate(Template updatedTemplate) {
    setState(() {
      template = updatedTemplate;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.grey.shade900.withAlpha(120),
                ),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade900.withAlpha(140),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Game Details',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TemplateDetails(
                    template: template,
                    onChanged: (updatedTemplate) =>
                        setTemplate(updatedTemplate),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonComponent(
                        shouldAnimate: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.grey.shade300,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ButtonComponent(
                        shouldAnimate: false,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackerPage(
                                template: template!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade900,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.grey.shade900,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class TemplateDetails extends StatefulWidget {
  TemplateDetails({
    super.key,
    required this.template,
    required this.onChanged,
  });

  final Template? template;

  final ValueChanged<Template> onChanged;

  @override
  State<TemplateDetails> createState() => _TemplateDetailsState();
}

class _TemplateDetailsState extends State<TemplateDetails> {
  Template template = Template(basePlayers, baseLife, true);

  TextStyle style = TextStyle(
    fontSize: 24,
    color: Colors.grey.shade300,
    decoration: TextDecoration.none,
  );

  TextStyle smallStyle = TextStyle(
    fontSize: 18,
    color: Colors.grey.shade300,
    decoration: TextDecoration.none,
  );

  subtractPlayer() {
    setState(() {
      if (template.playerCount > minPlayers) {
        template.playerCount -= 1;
      } else {
        template.playerCount = minPlayers;
      }
    });

    widget.onChanged(template);
  }

  addPlayer() {
    setState(() {
      if (template.playerCount < maxPlayers) {
        template.playerCount += 1;
      } else {
        template.playerCount = maxPlayers;
      }
    });

    widget.onChanged(template);
  }

  subtractLife() {
    setState(() {
      if (template.startingLife > minLife) {
        template.startingLife -= 5;
      } else {
        template.startingLife = minLife;
      }
    });

    widget.onChanged(template);
  }

  addLife() {
    setState(() {
      if (template.startingLife < maxLife) {
        template.startingLife += 5;
      } else {
        template.startingLife = maxLife;
      }
    });

    widget.onChanged(template);
  }

  toggleCommander() {
    setState(() {
      template.commander = !template.commander;
    });

    widget.onChanged(template);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Players',
                style: style,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.remove),
                    color: Colors.grey.shade300,
                    onPressed: template.playerCount > minPlayers
                        ? () {
                            subtractPlayer();
                          }
                        : null,
                  ),
                  Text(
                    '${template.playerCount}',
                    style: style,
                  ),
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.add),
                    color: Colors.grey.shade300,
                    onPressed: template.playerCount < maxPlayers
                        ? () {
                            addPlayer();
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Starting Life',
                style: style,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.remove),
                    color: Colors.grey.shade300,
                    onPressed: template.startingLife > minLife
                        ? () {
                            subtractLife();
                          }
                        : null,
                  ),
                  Text(
                    '${template.startingLife}',
                    style: style,
                  ),
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.add),
                    color: Colors.grey.shade300,
                    onPressed: template.startingLife < maxLife
                        ? () {
                            addLife();
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Commander',
              style: style,
            ),
            SizedBox(width: 16),
            Container(
              margin: EdgeInsets.only(bottom: 2.5),
              child: Text(
                'Damage Affects',
                style: smallStyle,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonComponent(
              shouldAnimate: false,
              onPressed: () => {
                toggleCommander(),
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: template.commander
                        ? Colors.grey.shade300
                        : Colors.grey.shade900,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Life + Damage',
                  style: TextStyle(
                    fontSize: 18,
                    color: template.commander
                        ? Colors.grey.shade300
                        : Colors.grey.shade600,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            ButtonComponent(
              shouldAnimate: false,
              onPressed: () => {
                toggleCommander(),
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: template.commander
                        ? Colors.grey.shade900
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Damage Only',
                  style: TextStyle(
                    fontSize: 18,
                    color: template.commander
                        ? Colors.grey.shade600
                        : Colors.grey.shade300,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
