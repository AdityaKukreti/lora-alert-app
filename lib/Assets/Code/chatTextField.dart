import 'package:flutter/material.dart';

class Chattextfield extends StatefulWidget {
  const Chattextfield(
      {super.key,
      required this.controller,
      required this.onSend,
      required this.ai,
      required this.onLocation});
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onLocation;
  final bool ai;

  @override
  State<Chattextfield> createState() => _ChattextfieldState();
}

class _ChattextfieldState extends State<Chattextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(60),
          border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: (str) {
              setState(() {});
            },
            textAlignVertical: TextAlignVertical.bottom,
            maxLength: 200,
            minLines: 1,
            maxLines: 2,
            controller: widget.controller,
            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              hintText: "Message...",
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width *
                      (widget.controller.text.isEmpty ? 0.6 : 0.65)),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              // contentPadding:
              //     EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),

              helperStyle: TextStyle(fontSize: 0),
            ),
          ),
          widget.ai == false
              ? widget.controller.text.isEmpty
                  ? IconButton(
                      onPressed: widget.onLocation,
                      icon: Icon(Icons.location_on))
                  : SizedBox()
              : SizedBox(),
          IconButton(onPressed: widget.onSend, icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
