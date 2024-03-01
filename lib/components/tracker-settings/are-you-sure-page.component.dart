import 'package:flutter/material.dart';

const double size = 44;

class AreYouSurePage extends StatelessWidget {
  const AreYouSurePage({
    super.key,
    required this.duration,
    required this.curve,
    required this.pageController,
    required this.toggle,
  });

  final Duration duration;
  final Curve curve;

  final PageController pageController;
  final VoidCallback toggle;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Expanded(
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset?',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.grey.shade300,
                    decoration: TextDecoration.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: size,
                      color: Colors.grey.shade300,
                      onPressed: () => {
                        pageController.nextPage(
                          duration: duration,
                          curve: curve,
                        ),
                      },
                      icon: Icon(Icons.close_rounded),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      iconSize: size,
                      color: Colors.grey.shade300,
                      onPressed: () => {
                        toggle(),
                      },
                      icon: Icon(Icons.done_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
