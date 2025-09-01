import 'package:flutter/material.dart';

enum PriorityLevel {
  low('Low priority', Colors.green),
  medium('Medium priority', Colors.orange),
  high('High priority', Colors.red);

  final String label;
  final Color color;

  const PriorityLevel(this.label, this.color);

  static Color toColor(String priorityLabel) {
    return PriorityLevel.values.firstWhere(
      (e) => e.label.toLowerCase() == priorityLabel.toLowerCase(),
      orElse: () => PriorityLevel.low,
    ).color;
  }
}
