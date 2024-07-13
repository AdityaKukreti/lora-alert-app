import 'package:flutter/material.dart';

import 'font.dart';

class SelectButton extends StatefulWidget {
  const SelectButton(
      {super.key,
      required this.state,
      required this.selected,
      required this.onTap});
  final String state;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onTap,
      style: ButtonStyle(
          side: WidgetStateProperty.all(BorderSide(
              color: widget.selected ? Colors.transparent : Colors.black,
              width: 1)),
          backgroundColor: WidgetStateProperty.all(
              widget.selected ? Colors.black : Colors.transparent)),
      child: MyFont(
        text: widget.state,
        color: widget.selected ? Colors.white : Colors.black,
        weight: FontWeight.w500,
        size: 15,
      ),
    );
  }
}
