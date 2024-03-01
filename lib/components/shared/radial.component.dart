import 'dart:math';

import 'package:flutter/material.dart';

class RadialComponent extends StatelessWidget {
  const RadialComponent({
    super.key,
    required this.radius,
    required this.angle,
    required this.child,
  });

  final double radius;
  final double angle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.identity()
          ..translate(radius * cos(angle), radius * sin(angle)),
        child: child,
      ),
    );
  }
}
