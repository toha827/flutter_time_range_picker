import 'dart:math';
import 'package:flutter/material.dart';

//normalize angle
double normalizeAngle(double radians) {
  var normalized = atan2(sin(radians), cos(radians));
  normalized = normalized > 0 ? normalized : 2 * pi + normalized;
  return normalized;
}

//convert a time to the correct angle of the clock
double timeToAngle(DateTime date, double offsetRad) {
  int min = date.hour * 60 + date.minute;
  double angle = min * pi * 2 / 60 / 24;
  return normalizeAngle(angle + pi / 2 + offsetRad);
}

//

//get signed Angle between two rad
double signedAngle(double startAngle, double targetAngle) {
  //return (startAngle - targetAngle).abs() % 360;
  return atan2(sin(startAngle - targetAngle), cos(startAngle - targetAngle));
}

double durationToAngle(Duration duration) {
  var min = duration.inMinutes;
  var time = DateTime.now().copyWith(hour: min ~/ 60, minute: min % 60);

  return signedAngle(timeToAngle(time, 0), pi / 2);
}

enum ActiveTime { Start, End }

class DateRange {
  DateTime startTime;
  DateTime endTime;

  DateRange({
    required this.startTime,
    required this.endTime,
  });

  String toString() {
    return "Start: ${startTime.toString()} to ${endTime.toString()}";
  }
}

class ClockLabel {
  double angle;
  String text;

  ClockLabel({required this.angle, required this.text});

  factory ClockLabel.fromDegree({required double deg, required String text}) {
    return ClockLabel(angle: deg * pi / 180, text: text);
  }

  factory ClockLabel.fromTime({required DateTime time, required String text}) {
    double angle = timeToAngle(time, 0);

    return ClockLabel(angle: angle, text: text);
  }

  factory ClockLabel.fromIndex(
      {required int idx, required int length, required String text}) {
    double angle = (2 * pi / length) * idx + pi / 2;

    return ClockLabel(angle: angle, text: text);
  }
}
