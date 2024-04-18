import 'package:flutter/material.dart';
import 'package:offline_music/helper/nav_observer.dart';

BuildContext? getCtx([BuildContext? oldContext]) =>
    NavObserver.navKey.currentContext ?? oldContext;
