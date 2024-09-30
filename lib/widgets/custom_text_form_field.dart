import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? labelText;
  bool? obscureText;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  CustomTextFormField(
      {required this.labelText,
      this.obscureText,
      this.suffixIcon,
      this.onChanged,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 22),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
