import 'package:flutter/material.dart';

import 'font.dart';

class Button extends StatefulWidget {
  const Button(
      {super.key,
      required this.function,
      required this.text,
      required this.backgroundColor,
      required this.textColor,
      required this.textSize,
      required this.width,
      required this.height,
      this.enabled = true});
  final VoidCallback function;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final double width;
  final double height;
  final bool enabled;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.function,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: widget.backgroundColor,
      child: MyFont(
        size: widget.textSize,
        text: widget.text,
        weight: FontWeight.w600,
        color: widget.textColor,
      ),
      minWidth: widget.width,
      height: widget.height,
    );
  }
}
