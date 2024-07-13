import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      required this.text,
      required this.icon});
  final TextEditingController controller;
  final String text;
  final IconData icon;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: widget.text,
          prefixIcon: Icon(widget.icon)),
    );
  }
}

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield(
      {super.key, required this.controller, required this.text});
  final TextEditingController controller;
  final String text;

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecure,
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.password),
          suffixIcon: IconButton(
            icon:
                Icon(obsecure ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
            onPressed: () {
              obsecure = !obsecure;
              setState(() {});
            },
          ),
          hintText: widget.text),
    );
  }
}
