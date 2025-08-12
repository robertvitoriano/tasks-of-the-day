import 'package:flutter/material.dart';

extension HexColorExtension on String {
  Color toColor() {
    final hex = replaceFirst('#', '');
    final buffer = StringBuffer();
    if (hex.length == 6) buffer.write('ff');
    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
