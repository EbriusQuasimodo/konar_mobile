import 'package:flutter/material.dart';

class BigWelcomeText extends StatelessWidget {
  final String text;
  const BigWelcomeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: Colors.blue[900]),
    );
  }
}
