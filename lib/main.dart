import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/pages/template.page.dart';
import 'package:test_app/pages/tracker.page.dart';
import 'pages/home.page.dart';

void main() {
  runApp(const MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      title: 'Life Tracker',
      scrollBehavior: AppScrollBehavior(),
      color: Color.fromARGB(255, 30, 30, 30),
      theme: ThemeData(
        textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),

      // routes: {
      //   '/': (context) => HomePage(),
      //   '/template': (context) => TemplatePage(),
      //   '/template/track': (context) => TrackerPage(),
      // },
    );
  }
}
