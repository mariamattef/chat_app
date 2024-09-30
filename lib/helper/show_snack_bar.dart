import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, Color? color, String? content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(content!),
  ));
}
