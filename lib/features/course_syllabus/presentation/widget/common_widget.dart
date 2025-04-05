import 'package:flutter/material.dart';

import '../../../../main.dart';


Future<TimeOfDay> showTimeDialog() async {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime = await showTimePicker(
    context: navigatorKey.currentState!.context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );

  return pickedTime!;
}

class Grades {
  final String label;
  final List<String> value;

  Grades(this.label, this.value);
}
