import 'package:flutter/material.dart';

/// Transforma minutos de `int` a `TimeOfDay`
TimeOfDay minutesToTimeOfDay(int minutes) {
  final int hours = minutes ~/ 60;
  final int remainingMinutes = minutes % 60;
  return TimeOfDay(hour: hours, minute: remainingMinutes);
}

/// Transforma minutos de `TimeOfDay` a `int`
int timeOfDayToMinutes(TimeOfDay time) {
  return (time.hour * 60) + time.minute;
}

/// Transforma minutos de `String` a `TimeOfDay`
///
/// *throw* `FormatException`
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

/// Transforma TameOfDay a string
///
/// Existe una función format de TimeOfDay, pero los locales hacen que en función
/// del idioma devuelva una respuesta distinta, por lo que no me sirve.
String timeOfDayToString(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, '0')}:"
      "${time.minute.toString().padLeft(2, '0')}";
}
