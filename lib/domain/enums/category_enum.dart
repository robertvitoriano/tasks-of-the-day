import 'package:flutter/material.dart';

enum Category {
  mediumPriority('Medium Priority', Colors.orange, Icons.priority_high),
  personal('Personal', Colors.blue, Icons.person),
  shopping('Shopping', Colors.green, Icons.shopping_cart),
  health('Health', Colors.red, Icons.favorite),
  others('Others', Colors.grey, Icons.more_horiz);

  final String label;
  final Color color;
  final IconData icon;

  const Category(this.label, this.color, this.icon);

  static Category fromLabel(String label) {
    return Category.values.firstWhere(
      (e) => e.label.toLowerCase() == label.toLowerCase(),
      orElse: () => Category.others,
    );
  }
}
