import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static parse12HoursTime(String timeString) {
    final parts = timeString.split(':');
    if (parts.length == 2) {
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1].split(' ')[0]);
      final period = parts[1].split(' ')[1].toLowerCase();

      if (hour != null && minute != null) {
        if (period == 'am' || (period == 'pm' && hour == 12)) {
          return TimeOfDay(hour: hour, minute: minute);
        } else if (period == 'pm' && hour > 0 && hour < 12) {
          return TimeOfDay(hour: hour + 12, minute: minute);
        }
      }
    }

    // Return a default time (midnight) in case of parsing failure
    return const TimeOfDay(hour: 0, minute: 0);
  }

  static format12HoursTime(TimeOfDay? pickedTime) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, pickedTime!.hour, pickedTime.minute);
    final format = DateFormat('hh:mm a'); //"6:00 AM"

    String formattedTime = format.format(dt);
    return formattedTime;
  }
}
