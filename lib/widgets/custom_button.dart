import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  void Function()? onPressed;
  CustomButton({required this.text, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text('$text',
            style: const TextStyle(
              fontSize: 23,
              color: kPrimaryColor,
            )),
      ),
    );
  }
}
