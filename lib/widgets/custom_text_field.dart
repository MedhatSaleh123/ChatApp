import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

// final TextEditingController controller = new TextEditingController();

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {this.icon,
      this.onChanged,
      this.obscureText = false,
      required this.hintText});
  String? hintText;
  bool? obscureText;
  Function(String)? onChanged;
  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      // controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
