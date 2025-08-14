import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    required this.onSelect,
    this.selectedValue,
    this.items,
  });

  String? selectedValue;
  List<DropdownMenuItem<String>>? items;

  final Function(String?)? onSelect;

  @override
  Widget build(Object context) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Priority',
          border: OutlineInputBorder(),
        ),
        value: selectedValue,
        items: items,
        onChanged: onSelect,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
      ),
    );
  }
}
