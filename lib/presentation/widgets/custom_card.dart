import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40), child: child),
    );
  }
}
