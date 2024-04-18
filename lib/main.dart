import 'package:flutter/material.dart';
import 'package:offline_music/helper/nav_helper.dart';
import 'package:offline_music/helper/nav_observer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Music',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      navigatorKey: NavObserver.navKey,
      navigatorObservers: [NavObserver.instance],
      onGenerateRoute: generateRoute,
      initialRoute: Path.home,
    );
  }
}
