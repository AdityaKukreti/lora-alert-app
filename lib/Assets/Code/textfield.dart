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

class DisabledTextfield extends StatefulWidget {
  const DisabledTextfield(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller});
  final String text;
  final IconData icon;
  final TextEditingController controller;

  @override
  State<DisabledTextfield> createState() => _DisabledTextfieldState();
}

class _DisabledTextfieldState extends State<DisabledTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      controller: widget.controller,
      enabled: false,
      decoration: InputDecoration(
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: widget.text,
          labelStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
          prefixIcon: Icon(widget.icon)),
    );
  }
}
