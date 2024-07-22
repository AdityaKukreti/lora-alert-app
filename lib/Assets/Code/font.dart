import 'package:flutter/material.dart';

class MyFont extends StatelessWidget {
  const MyFont(
      {super.key,
      required this.text,
      required this.size,
      required this.weight,
      required this.color});
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: color,
      ),
    );
  }
}
