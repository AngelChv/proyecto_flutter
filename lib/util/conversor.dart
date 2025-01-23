import 'package:flutter/material.dart';

TimeOfDay minutesToTimeOfDay(int minutes) {
  final int hours = minutes ~/ 60;
  final int remainingMinutes = minutes % 60;
  return TimeOfDay(hour: hours, minute: remainingMinutes);
}

int timeOfDayToMinutes(TimeOfDay time) {
  return (time.hour * 60) + time.minute;
}

TimeOfDay parseTimeOfDay(String timeString) {
  try {
    final parts = timeString.split(':');
    if (parts.length != 2) throw FormatException("Invalid TimeOFDay Format");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw FormatException("Hour or time out of bound");
    }
    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    throw FormatException("The string haven't the valid format: $timeString");
  }
}