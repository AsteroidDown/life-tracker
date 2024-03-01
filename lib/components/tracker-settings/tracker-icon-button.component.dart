import 'package:flutter/material.dart';

class TrackerIconButton extends StatelessWidget {
  const TrackerIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.size,
    required this.color,
    required this.duration,
    required this.onPressed,
  }) : super(key: key);

  final Icon icon;
  final String label;

  final double size;

  final Color color;

  final Duration duration;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: icon,
              color: color,
              iconSize: size,
              onPressed: onPressed,
              alignment: Alignment.topCenter,
            ),
            Container(
              transform: Matrix4.translationValues(0, -8, 0),
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
