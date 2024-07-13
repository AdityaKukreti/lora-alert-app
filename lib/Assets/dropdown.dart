import 'package:flutter/material.dart';

import 'font.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu(
      {super.key,
      required this.text,
      required this.icon,
      required this.list,
      required this.controller});
  final String text;
  final IconData icon;
  final List<DropdownMenuEntry<dynamic>> list;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: list,
      width: 300,
      controller: controller,
      onSelected: (value) {
        controller.text = value;
      },
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(20))),
      label: MyFont(
        text: text,
        size: 14,
        weight: FontWeight.w400,
        color: Colors.black,
      ),
      leadingIcon: Icon(
        icon,
      ),
    );
  }
}
