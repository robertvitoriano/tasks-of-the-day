import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PriorityItem extends StatelessWidget {
  const PriorityItem({super.key, required this.priority, required this.color});

  final String priority;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Text(priority),
      ],
    );
  }
}
