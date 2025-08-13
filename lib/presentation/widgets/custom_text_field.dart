import 'package:flutter/material.dart';

enum CustomTextFieldType { email, password, text }

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.type,
    required this.controller,
    this.maxLines = 1,
    this.label = '',
  });

  final String hintText;
  final String label;
  final int maxLines;
  final CustomTextFieldType type;
  final TextEditingController controller;

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return '$hintText is required';
    }

    switch (type) {
      case CustomTextFieldType.email:
        final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
        if (!emailRegex.hasMatch(value)) {
          return 'Enter a valid email';
        }
        break;

      case CustomTextFieldType.password:
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        break;

      case CustomTextFieldType.text:
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = type == CustomTextFieldType.password;

    final keyboardType = switch (type) {
      CustomTextFieldType.email => TextInputType.emailAddress,
      CustomTextFieldType.password => TextInputType.text,
      CustomTextFieldType.text => TextInputType.text,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            maxLines: maxLines,
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            validator: _validator,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
