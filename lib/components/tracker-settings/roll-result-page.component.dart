import 'package:flutter/material.dart';

class RollResultPage extends StatelessWidget {
  const RollResultPage({
    super.key,
    required this.rollResult,
    required this.duration,
    required this.pageController,
  });

  final int rollResult;
  final Duration duration;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 96,
      color: Colors.grey.shade300,
      decoration: TextDecoration.none,
    );

    return Expanded(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$rollResult',
                  style: style,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 36,
                      color: Colors.grey.shade200,
                      icon: Icon(Icons.arrow_back_rounded),
                      onPressed: () => {
                        pageController.previousPage(
                          duration: duration,
                          curve: Curves.easeOut,
                        ),
                      },
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      iconSize: 36,
                      color: Colors.grey.shade200,
                      icon: Icon(Icons.home_rounded),
                      onPressed: () => {
                        pageController.animateToPage(
                          1,
                          duration: duration,
                          curve: Curves.easeInOut,
                        ),
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
