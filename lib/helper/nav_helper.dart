import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:offline_music/helper/dependency.dart';
import 'package:offline_music/helper/nav_observer.dart';
import 'package:offline_music/ui/screen/home_screen.dart';
import 'package:offline_music/ui/screen/playing_now_screen.dart';

class Path {
  static const String home = "/";
  static const String playingNow = "/playingNow";
}

Route<Object?>? generateRoute(RouteSettings settings) {
  return getRoute(settings.name);
}

Route<Object?>? getRoute(String? name,
    {LinkedHashMap? args, Function? result}) {
  switch (name) {
    case Path.home:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: RouteSettings(name: name));
    case Path.playingNow:
      return MaterialPageRoute(
          builder: (context) => PlayingNowScreen(args),
          settings: RouteSettings(name: name));
  }
  return null;
}

Future openScreen(String routeName,
    {bool forceNew = false,
    bool requiresAsInitial = false,
    Map? args,
    Function? result}) async {
  var route =
      getRoute(routeName, args: LinkedHashMap.from(args ?? {}), result: result);
  final context = getCtx();
  if (route != null && context != null) {
    if (requiresAsInitial) {
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else if (forceNew || !NavObserver.instance.containsRoute(route)) {
      await Navigator.push(context, route);
    } else {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == routeName) {
          if (args != null) {
            (route.settings.arguments as Map)["result"] = args;
          }
          return true;
        }
        return false;
      });
    }
  }
}

void back([LinkedHashMap? args]) {
  final context = getCtx();
  if (context != null) {
    Navigator.pop(context, args);
  }
}
