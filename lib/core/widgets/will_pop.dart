import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myenglish/main.dart';

bool back = false;
int time = 0;
int duration = 1000;
Future<bool> willPop() async {
  int now = DateTime.now().millisecondsSinceEpoch;
  if (back && time >= now) {
    back = false;
    exit(0);
  } else {
    time = DateTime.now().millisecondsSinceEpoch + duration;
    print("again tap");
    back = true;
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text("Press again the button to exit")));
  }
  return false;
}
