import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/font.dart';

class Comment extends StatefulWidget {
  const Comment(
      {super.key,
      required this.username,
      required this.comment,
      required this.time});
  final String username;
  final String comment;
  final String time;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MyFont(
                  text: "@${widget.username}",
                  size: 14,
                  weight: FontWeight.w500,
                  color: Colors.black87),
              SizedBox(
                width: 5,
              ),
              Icon(
                CupertinoIcons.circle_filled,
                size: 5,
              ),
              SizedBox(
                width: 5,
              ),
              MyFont(
                  text: widget.time,
                  size: 14,
                  weight: FontWeight.w500,
                  color: Colors.black87),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          MyFont(
              text: "${widget.comment}",
              size: 15,
              weight: FontWeight.w400,
              color: Colors.black)
        ],
      ),
    );
  }
}
